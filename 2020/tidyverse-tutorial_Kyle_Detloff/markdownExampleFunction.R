# t-test power simulation function for markdown example
# Kyle Dettloff
# 11-13-2019

suppressMessages(library(dplyr))
suppressMessages(library(tidyr))
suppressMessages(library(ggplot2))
suppressMessages(library(knitr))

# create function to be run in RMarkdown
# enter all tweakable parameters and their defaults
tsimMult = function(nsim,
                    n11, n12, sd11, sd12,
                    n21, n22, sd21, sd22,
                    vareq1 = FALSE, vareq2 = FALSE,
                    alpha = .05,
                    simrange.max = 3) {

    # -------------------------------------------------------------
    # t-test simulation function
    tsim = function(mu, n1, n2, sd1, sd2, vareq) { 
    
      # create empty vector to store p-values
      pvals = rep(0, nsim)
      
      for (i in 1:nsim) {
        
        p1 = rnorm(n1, 0, sd1)
        p2 = rnorm(n2, mu, sd2)
        
        pvals[i] = t.test(p1, p2, var.equal = !vareq)$p.value
        
      }
      mean(pvals < alpha)
    } # end function
    # -------------------------------------------------------------
  
  # create a sequence of values incrementing by 0.1 that will be passed to the 'mu' parameter in the tsim function
  mudiff = seq(0, simrange.max, by = 0.1)
  
  # use mapply (multivariate apply) to run the tsim function for each mu value in the sequence generated above
  sim1 = mapply(tsim, mu = mudiff, n1 = n11, n2 = n12, sd1 = sd11, sd2 = sd12, vareq = vareq1) # scenario 1
  sim2 = mapply(tsim, mu = mudiff, n1 = n21, n2 = n22, sd1 = sd21, sd2 = sd22, vareq = vareq2) # scenario 2
  
  # combine vectors generated above into a dataframe
  df = data.frame(mudiff, sim1, sim2)
  # convert data from wide-form to long-form to be ggplot friendly
  dflong = df %>% gather(size, power, -mudiff)
  
  # plot curves with ggplot2
  figure = dflong %>% ggplot(aes(x = mudiff, y = power, colour = size)) + geom_line(size = 1.5) +
    geom_hline(yintercept = alpha, lty = 2) +
    labs(x = "Difference in Means", y = "Power", colour = "", title = "Two sample t-test Power Curves") +
    ylim(0, NA) +
    theme(panel.background = element_blank(),
          panel.grid.major.x = element_line(colour = "grey90"),
          panel.grid.minor.x = element_blank(),
          panel.grid.major.y = element_line(colour = "grey90"),
          panel.grid.minor.y = element_line(colour = "grey90"),
          legend.position = "bottom")
  
  # create table of values with knitr::kable
  table = kable(df, digits = 3,
                col.names = c("Difference in Means", "Simulation 1", "Simulation 2"),
                caption = paste0("H~0~ Rejection Rates, alpha = ", alpha))
  
  # list of output on last line
  list(figure, table)

}
