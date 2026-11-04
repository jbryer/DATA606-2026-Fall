library(ggplot2)
ggplot2::theme_set(ggplot2::theme_minimal())

data(mtcars)
head(mtcars)

# The standard deviations of wt and mpg are different
sd(mtcars$wt)
sd(mtcars$mpg)

ggplot(mtcars, aes(x = wt, y = mpg)) + geom_point()

# Create z-scores for wt and mpg
mtcars <- mtcars |>
	dplyr::mutate(wt_z = as.numeric(scale(wt)),
				  mpg_z = as.numeric(scale(mpg)))


# The correlations are the same, as expected
(r <- cor(mtcars$mpg, mtcars$wt))
(r_z <- cor(mtcars$mpg_z, mtcars$wt_z))

# But since the standard deviations are different, the slope will be different
(m <- r * (sd(mtcars$mpg) / sd(mtcars$wt)))
(m_z <- r_z * (sd(mtcars$mpg_z) / sd(mtcars$wt_z)))

# And too the intercept
(b <- mean(mtcars$mpg) - m * mean(mtcars$wt))
(b <- mean(mtcars$mpg_z) - m_z * mean(mtcars$wt_z))

# We can verify they are different using the lm function
lm(mpg ~ wt, data = mtcars)
lm(mpg_z ~ wt_z, data = mtcars)
