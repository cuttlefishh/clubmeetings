# Two sample t-test simulation shiny app
# Kyle Dettloff
# 04-01-2020

library(shiny)
library(shinythemes)
library(ggplot2)

# Define UI for application that simulates a two sample t-test
ui <- fluidPage(
    
    # Application title
    titlePanel(h1("Two sample t-test power simulation",
                  style = 'background-color:aliceblue;
                  padding-left: 12px'),
               windowTitle = "t-test power simulation"),
    
    # Sidebar to input simulation parameters 
    sidebarPanel(
        sliderInput("nsim",
                    "Number of simulations:",
                    min = 100,
                    max = 10000,
                    value = 1000,
                    step = 10),
        numericInput("alpha",
                     "alpha",
                     min = 0,
                     max = 1,
                     value = 0.05),
        numericInput("sim.n1",
                     "Sample size (Pop 1)",
                     min = 2,
                     value = 10),
        numericInput("sim.sd1",
                     "Standard deviation (Pop 1)",
                     min = 0,
                     value = 1),
        numericInput("sim.n2",
                     "Sample size (Pop 2)",
                     min = 2,
                     value = 10),
        numericInput("sim.sd2",
                     "Standard deviation (Pop 2)",
                     min = 0,
                     value = 1),
        checkboxInput("sim.eqvar",
                      "Unequal variance?",
                      value = FALSE),
        actionButton("run", "Run",
                     class = "btn-primary")
    ),
    # Show a plot and table of results
    mainPanel(
        plotOutput("powerPlot"),
        dataTableOutput("powerTable")
    ),
    # Modify theme
    theme = shinytheme("cerulean")
)

# Define server logic required to generate power curves
server <- function(input, output) {
    
    ### t-test simulation function
    tsim <- function(nsim, mu, alpha, n1, n2, sd1, sd2, vareq) { 
        
        # create empty vector to store p-values
        pvals <- rep(0, nsim)
        
        for (i in 1:nsim) {
            
            p1 <- rnorm(n1, 0, sd1)
            p2 <- rnorm(n2, mu, sd2)
            
            pvals[i] <- t.test(p1, p2, var.equal = !vareq)$p.value
            
        }
        mean(pvals < alpha)
    } ### end of function
    

    ### define dynamic inputs -------------------------------------------------------------------------
    pwr_table <- eventReactive(input$run, {
        
        powerfun <- function(mudiff) {
            # use mapply (multivariate apply) to run the tsim function for multiple supplied input parameters
            mapply(tsim, nsim = input$nsim, mu = mudiff, alpha = input$alpha,
                   n1 = input$sim.n1, n2 = input$sim.n2,
                   sd1 = input$sim.sd1, sd2 = input$sim.sd2,
                   vareq = input$sim.eqvar)
            }
        
        # initialize while loop values
        simpower <- mudiff <- z <- 0
        # create empty dataframe to store results
        dfr <- data.frame(mudiff = numeric(0), simpower = numeric(0))
        
        # simulate for difference in means until power reaches 1 (terminate loop at max difference of 10)
        while (simpower < 1 && mudiff < 10 || mudiff < 1) {
            
            simpower <- powerfun(mudiff)
            z <- z + 1
            dfr[z, ] <- c(mudiff, round(simpower, 3))
            mudiff <- round(mudiff + 0.1, 1)
            
            }
        # return result
        dfr
        })
    ### -----------------------------------------------------------------------------------------------
    
    # generate power plot based on input parameters from ui.R
    output$powerPlot <- renderPlot({
        ggplot(pwr_table(), aes(x = mudiff, y = simpower)) +
            geom_line(size = 1.2, colour = "#007ba7") +
            geom_hline(yintercept = input$alpha, lty = 2) +
            labs(x = "Difference in Means", y = "Power") +
            ylim(0, NA) +
            theme(panel.background = element_blank(),
                  panel.grid.major.x = element_line(colour = "grey90"),
                  panel.grid.minor.x = element_blank(),
                  panel.grid.major.y = element_line(colour = "grey90"),
                  panel.grid.minor.y = element_line(colour = "grey90"),
                  axis.text = element_text(size = 14),
                  axis.title = element_text(size = 14, face = "bold"))
        })
    
    # generate power table based on input parameters from ui.R
    output$powerTable <- renderDataTable({
        pwr_table()
    },
    options = list(columns = list(list(title = "Difference in Means"),
                                  list(title = paste0("H<sub>0</sub> Rejection Rate (\U03B1 = ", input$alpha, ")"))),
                   searching = FALSE, pageLength = 20,
                   lengthMenu = list(c(10, 20, 50, -1), c('10', '20', '50', 'All')))
    )
}

# Run the application 
shinyApp(ui = ui, server = server)