library(ggplot2)


tibble::tribble(
  ~a, ~b, ~c,
  1, 1, "cj",
  2, 1, "liu",
  1, 2, "c",
  2, 2, "j"
) -> .d_text

.d_text %>% dplyr::slice(c(1,3)) -> .d_text_l
.d_text %>% dplyr::slice(c(2,4)) -> .d_text_r
.d_seg <- tibble::tibble(x1 = c(1 ,1) , y1 = c(1, 2), x2 = c(2, 2), y2 = c(1, 2))

ggplot() +
  geom_segment(data = .d_seg, mapping = aes(
    x = x1, 
    y = y1,
    xend = x2,
    yend = y2
  )) +
  geom_text(
    data = .d_text_l, 
    mapping = aes(x = a, y = b, label = c),
    hjust = 1) +
  geom_text(
    data = .d_text_r, 
    mapping = aes(x = a, y = b, label = c),
    hjust = -0.5) +
  theme(
    panel.background = element_blank(),
    axis.title = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank()
  )

  
