# load packages needed to run this code
library(ggplot2)
library(dplyr)
library(tidyr)
library(cowplot)
library(gganimate)

# make a data frame for a tree
tree_df <- data.frame(x = c(0, 1, 2, 3, 3, 5, 0, 5, 3, 5, 3, 5),
                      y = c(5, 6, 7, 10, 8, 8, , 0, 8, 6, 2, 4),
                      branch = c('b1', 'b1', 'b1', 'b1', 'b2', 'b2', 'b3', 'b3', 'b4', 'b4'),
                      sequence = c("DP GESFF…",
                                   "DP GESFF…",
                                   "DPNGESFF…",
                                   "EPNGESFF…",
                                   "KPNGESDK…",
                                   "KPNGESDK…",
                                   "DPHGESFF…",
                                   "DPHGESFF…",
                                   "IPHGENRR…",
                                   "IPHGENRR…"),
                      subs = c("  H     ",
                               "  N     ",
                               "DPNGESFF…",
                               "EPNGESFF…",
                               "KPNGESDK…",
                               "KPNGESDK…",
                               "DPHGESFF…",
                               "DPHGESFF…",
                               "IPHGENRR…",
                               "IPHGENRR…"),
                      type = c("#5893d4",
                               "#f7aa00", 
                               "black",
                               "black",
                               "black",
                               "black",
                               "black",
                               "black",
                               "black",
                               "black"))

subs_df <- data.frame(time = c(1, 2.5, 2, 2.5, 4, 4.5),
                      position = c(6, 7.5, 3, 2.5, 1, 9.5),
                      type = c(1:6))

ancestor_seq <- "DPHGESFF…"

ggplot(tree_df, aes(x = time, y = position, group = branch)) + 
  geom_path(size = 1) +
  scale_y_continuous(limits = c(0,10), breaks = c(1:10)) +
  scale_x_continuous(limits = c(0,10), breaks = c(1:10)) +
  background_grid(major = "xy") +
  geom_text(aes(label = branch))

ggplot(data = tree_df, mapping = aes(x = time, y = position)) + 
  geom_line(aes(group = branch), size = 1.5) + 
  #geom_segment(aes(xend = time, yend = position), linetype = 2, colour = 'grey') + 
  #geom_point(aes(color = sequence), size = 3) +
  geom_text(aes(label = sequence),
            hjust = 0,
            nudge_x = 0.2,
            size = 6,
            family = "Courier",
            color = "black") +
  geom_text(aes(label = subs, color = type),
            hjust = 0,
            nudge_x = 0.2,
            size = 6,
            family = "Courier") +
  geom_text(x = 0, y = 5, 
            label = ancestor_seq,
            hjust = 1,
            nudge_x = -0.4,
            size = 6,
            family = "Courier") +
  transition_reveal(branch, time) + 
  coord_cartesian(clip = 'off', xlim = c(-2, 7)) +
  scale_color_discrete(guide = 'none') +
  theme_void()

