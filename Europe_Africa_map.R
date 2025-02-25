#I prepared this map to show different countries from where cattle breeds were selected for multiomic study as part of OPTIBOV project. I had to do some manual editing in Inkscape to get what I wanted :) 

# Install necessary packages if you haven't already
install.packages("ggplot2")
install.packages("maps")
install.packages("dplyr")

# Load the libraries
library(ggplot2)
library(maps)
library(dplyr)

# Get the world map data
world_map <- map_data("world")

# Filter for Europe and Africa
europe_africa <- world_map %>%
  filter(long > -30 & long < 60 & lat > -40 & lat < 70)

# Coordinates for the countries
country_coords <- data.frame(
  country = c("Finland", "Portugal", "Netherlands", "South Africa", "Egypt", "Uganda"),
  long = c(25, -8, 5, 22, 30, 32),
  lat = c(60, 37, 52, -30, 26, 1),
  label_long = c(65, 65, 65, 65, 65, 65),  # Adjusted label positions to the right
  label_lat = c(60, 37, 52, -30, 26, 1)
)

# Plot the map with latitude-based coloring and country labels
ggplot(data = europe_africa) +
  geom_polygon(aes(x = long, y = lat, group = group, fill = lat), color = "black", size = 0.2) +
  scale_fill_gradient(low = "#ffffcc", high = "#ffcc00", name = "Latitude", 
                      guide = guide_colorbar(title.position = "top", title.hjust = 0.5)) +  # Yellow gradient with legend at bottom
  theme_minimal() +
  theme(panel.grid = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        legend.position = "bottom",  # Position the legend at the bottom
        legend.title = element_text(size = 10, face = "bold"),
        legend.text = element_text(size = 8),
        plot.margin = unit(c(1, 1, 1, 1), "cm"),  # Increase plot margins
        plot.title = element_blank(),  # Remove the title
        axis.title = element_blank(),  # Remove x and y axis titles
        aspect.ratio = 2) +  # Further increase the height of the plot
  coord_fixed(xlim = c(-30, 60), ylim = c(-40, 70)) +
  geom_segment(data = country_coords, aes(x = label_long, y = label_lat, xend = long, yend = lat),
               arrow = arrow(length = unit(0.2, "cm")), color = "darkred") +
  geom_text(data = country_coords, aes(x = label_long, y = label_lat, label = country), 
            size = 5, fontface = "bold", color = "darkred", hjust = 0)
