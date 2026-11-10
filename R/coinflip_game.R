# https://www.instagram.com/reel/De5z-rdN0d1/?rpxt=ZmsydGtibjBnZjNv
library(ggplot2)
ggplot2::theme_set(ggplot2::theme_minimal())

combinations <- list(
	c('H', 'H'),
	c('H', 'T')
)
N <- 10000 # How many simulations
winner <- data.frame(winner = character(N), flips = integer(N))
for(i in 1:N) {
	previous_flip <- sample(c('H', 'T'), 1)
	j <- 1
	repeat {
		current_flip <- sample(c('H', 'T'), 1)
		j <- j + 1
		stop <- FALSE
		for(k in combinations) {
			if(k[1] == previous_flip & k[2] == current_flip) {
				winner[i,]$winner <- paste0(k, collapse = '')
				winner[i,]$flips <- j
				stop <- TRUE
				break;
			}
		}
		if(stop) { break; }
		previous_flip <- current_flip
	}
}
head(winner)

# winner$winner |> table() |> prop.table()

winner |> 
	dplyr::group_by(winner) |> 
	dplyr::summarize(
		n = dplyr::n(),
		mean = mean(flips),
		percent_wins = 100 * (n / N),
		sd = mean(flips),
		se = sd(flips) / sqrt(n)
	)

ggplot(winner, aes(x = flips, color = winner)) + 
	geom_density(adjust = 3)

# I misunderstood the problem and stopped whenever I saw a winnig combination

# From Google AI
# Monte Carlo Simulation: HH vs HT Expected Flip Count
set.seed(42) # For reproducible results
num_simulations <- 100000

simulate_sequence <- function(target) {
	flips <- c()
	while(TRUE) {
		flips <- c(flips, sample(c("H", "T"), 1))
		len <- length(flips)
		if(len >= 2) {
			last_two <- paste0(flips[len-1], flips[len])
			if(last_two == target) {
				return(len)
			}
		}
	}
}

# Run simulations
hh_results <- replicate(num_simulations, simulate_sequence("HH"))
ht_results <- replicate(num_simulations, simulate_sequence("HT"))

# Calculate and display the averages
cat("Average flips to get HH:", mean(hh_results), "\n")
cat("Average flips to get HT:", mean(ht_results), "\n")
