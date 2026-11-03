library(ggplot2)
library(VisualStats)
ggplot2::theme_set(ggplot2::theme_minimal())

# remotes::install_github('coolbutuseless/ggsvg')

set.seed(42)

# The actual squirrel population https://2019.thesquirrelcensus.com
N <- 2373
squirrel_pop <- seq(1, N)

central_park <- c(width = 2640, height = 13200) # In feet (approximately 0.5mi wide, 2.5mi long)
squirrels <- data.frame(
	id = 1:N,
	x = runif(N, min = 0, max = central_park[1]),
	y = runif(N, min = 0, max = central_park[2])
) |>
	dplyr::arrange(x, y)

squirrel_svg <- '<svg fill="#000000" height="800px" width="800px" version="1.2" baseProfile="tiny" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
	  viewBox="0 0 256 256" xml:space="preserve">
<path d="M103.2,236.6H89.4c-1.3,0-2.7-0.1-3.9-0.1c-0.1,0-0.1,0-0.1,0c-1.1,0.1-2.2,0.1-3.3,0.1c-30.2,0-60-24.2-73.1-49.2
	c-2.2-4.3-4.1-8.9-5.6-13.6C1.2,166.6,0,158.9,0,150.9c0-10.9,2.2-21.3,6.2-30.7c4.1-12,12-24.2,26.4-35.1
	c24.8-18.8,13.8-47.3,13.8-47.3c3.2-0.6,6.3-0.9,9.4-0.9c23.4,0,43.6,23.8,46.2,45c0.3,1.9,0.4,3.8,0.4,5.8c0,8.4-3.3,15.3-8,21.8
	c-9.7,8.6-17.4,19.4-22,31.6c-1.9,4.9-3.2,10-4.1,15.3c-0.7,4.3-1.1,8.8-1.1,13.4C67.1,197.6,81.5,222.4,103.2,236.6z M253,142.2
	c0,0.1,0,0.2,0,0.3c0,0.2,0,0.3,0,0.4c0,5.9-4.8,10.7-10.7,10.7h-18.7c-2.8,2.2-5.6,4.7-8.6,7c-0.9,0.7-1.8,1.3-2.7,1.9
	c-1,0.8-2,1.4-3.1,2c-0.8,0.3-1.6,0.8-2.3,1.1c-2.7,1.2-5.5,2-8.5,2c-0.2,0-0.3,0-0.6,0c-0.9,0-1.9-0.1-2.8-0.2
	c-8.5-0.9-12.6-6-16.4-13.2c-0.1-0.1-0.2-0.2-0.3-0.3c-2.7-3.2-5.1-4.9-7.1-5.7c-6.6-4.2-14.4-6.8-22.7-6.9l0.6,4.1
	c20.9,0.7,37.7,17.8,37.7,38.9c0,11.9-5.5,22.6-13.9,29.7c6.6,1,12.2,4.9,15.7,10.2c1.1,1.7,2,3.7,2.7,5.7c0.7,2.1,1.1,4.5,1.1,6.8
	h-4.8h-5.2h-12.2h-23.7h-30.2c-16.4-7.8-30.1-21.3-37.2-38c-3-6.9-4.9-14.5-5.6-22.3c-0.7-4.2-1-8.6-1-12.9
	c0-18.6,20.9-57.1,52.1-65.9c0,0,23.8-9.1,26.6-10.2c24.2-10,16.9-23.3,23-32.8c7.3-11.5,17.3-12.4,17.3-12.4L205,25.8l4.7-5.5
	c3.6,0,6.5,12.7,7,23.4c27.4,12.8,31.4,40.9,31.4,52c0,12-6.3,17.9-15.6,20.3c-4.2,1-10,1.3-15.3,1.3c-6.2,0-11.5-0.4-11.5-0.4
	c0,0.9,7.3,15.1,7.3,15.1h20.2c1.2-0.1,2.6-0.2,3.8-0.2c1.2,0,2.4,0.1,3.7,0.2h1.6c3,0,5.7,1.3,7.7,3.3c1.3,1.2,2.1,2.4,2.3,3.8
	C252.8,140.2,253,141.2,253,142.2z M207.1,72c0,4.1,3.3,7.5,7.5,7.5s7.5-3.3,7.5-7.5c0-4.1-3.3-7.5-7.5-7.5S207,67.9,207.1,72z"/>
</svg>'

ggplot(squirrels, aes(x = x, y = y)) +
	geom_point(alpha = 0.5) +
	xlim(c(0, central_park[1])) +
	ylim(c(0, central_park[2])) +
	coord_equal() +
	theme(
		# Remove background and grid lines
		panel.background = element_blank(),
		panel.grid.major = element_blank(),
		panel.grid.minor = element_blank(),
		plot.background = element_blank(),
		
		# Remove axis text, titles, and ticks
		axis.title = element_blank(),
		axis.text = element_blank(),
		axis.ticks = element_blank()
	)

ggplot(squirrels, aes(x = x, y = y)) +
	ggsvg::geom_point_svg(aes(x = x, y = y), svg = squirrel_svg, size = 3) +
	xlim(c(0, central_park[1])) +
	ylim(c(0, central_park[2])) +
	coord_equal() +
	theme(
		# Remove background and grid lines
		panel.background = element_blank(),
		panel.grid.major = element_blank(),
		panel.grid.minor = element_blank(),
		plot.background = element_blank(),
		
		# Remove axis text, titles, and ticks
		axis.title = element_blank(),
		axis.text = element_blank(),
		axis.ticks = element_blank()
	)


n_catch <- 200 # How many squirrels will we catch, mark, release, and catch again

# set.seed(2112)
samp1 <- sample(squirrel_pop, n_catch)
samp1

samp2 <- sample(squirrel_pop, n_catch)
samp2

# how many squirrels were caught twice
n_recaught <- sum(samp2 %in% samp1)
n_recaught

# This vector are guesses for how many squirrels there are
n_draw <- 100000
prior_squirrels <- sample(n_catch:10000, n_draw, replace = TRUE)
# Also called the prior distribution
ggplot(data.frame(prior = prior_squirrels), aes(x = prior)) + 
	geom_histogram(aes(y = after_stat(density)), binwidth = 50, alpha = 0.5) +
	geom_density(linewidth = 1, bounds = range(prior_squirrels)) +
	ggtitle('Prior Distribution')

# The generative model
# This function replicates our actually procedure. Create a vector equal to the
# population guess (n paramter), sample from that vector to see how many squirrels
# we re-caught.
pick_squirrels <- function(n) { 
	# Create a vector of 0s and 1s equal the assumed population size (i.e. n)
	# The number of 1s is equal to n_catch, which is the number we actually observed
	# The rest are 0s
	squirrels <- rep(0:1, c(n - n_catch, n_catch))
	# We sample n_mark from this assumed population and see how many are 1s (meaning we recaught the squirrel)
	sample(squirrels, n_catch) |> sum()
}

n_marked <- rep(NA, n_draw)
for(i in seq_len(length(n_marked))) {
	n_marked[i] <- pick_squirrels(prior_squirrels[i])
}

# Subset from the population where n_marked matches our actual procedure
post_squirrels <- prior_squirrels[n_marked == n_recaught]
hist(post_squirrels, main='Posterior Distribution')

ggplot() + 
	geom_dist(prior_squirrels, quantile = 0, 
			  center_fun = function(x) { NA }, color = '#fdc086') +
	geom_dist(post_squirrels, quantile = 0.89, color = '#7fc97f') +
	# geom_vline(xintercept = mean(post_squirrels), linetype = 2) +
	geom_vline(xintercept = median(post_squirrels), linetype = 2) +
	geom_vline(xintercept = N, linetype = 1, alpha = 0.5) +
	ggtitle('Prior (orange) and Posterior (green) Distributions',
			subtitle = 'Shaded area is the 89% credible interval')

N
median(post_squirrels)
mean(post_squirrels)

# 89% credible interval: https://easystats.github.io/bayestestR/articles/credible_interval.html
ci_level <- .89
quantile(post_squirrels, probs = c((1 - ci_level) / 2, 1 - (1 - ci_level) /2))
