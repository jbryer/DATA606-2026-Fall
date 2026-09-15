library(ggplot2)
data(mtcars)

n_bins <- 10

ggplot(mtcars, aes(x = mpg)) + geom_histogram(bins = n_bins)
ggplot(mtcars, aes(x = mpg)) + geom_density()

range(mtcars$mpg)
mtcars$mpg_bin <- cut(mtcars$mpg, 
					  breaks = seq(from = min(mtcars$mpg), to = max(mtcars$mpg), length.out = n_bins), 
					  include.lowest = TRUE, 
					  labels = LETTERS[1:(n_bins - 1)])

tab_bins <- mtcars$mpg_bin |> table() |> as.data.frame()
tab_bins$rel_mpg_bin <- tab_bins$Freq / sum(tab_bins$Freq)
tab_bins

sum(tab_bins$rel_mpg_bin)

ggplot(tab_bins, aes(x = Var1, y = rel_mpg_bin)) + geom_bar(stat = 'identity')
