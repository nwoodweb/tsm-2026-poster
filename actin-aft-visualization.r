require(tidyverse)
require(dunn.test)


data.fft <- read.csv('/home/woodn/Desktop/order-fft-16feb26.csv')

# visualization
ggplot(data = data.fft) + 
    stat_summary(aes(x=ph,y=fft,fill=ph),
                 geom = 'bar', fun = 'mean', color = '#000000', size = 0.8) + 
    stat_summary(aes(x=ph,y=fft), fun.data = mean_sdl,fun.args=list(mult=1), geom = 'errorbar',
                 position = position_dodge(width = 0.9), width = 0.34) +
    facet_wrap(as.factor(data.fft$time)) + 
    guides(pattern = "none", fill = "none") + 
    xlab('') + 
    ylab('Order Parameter') + 
    scale_fill_manual(name ='pHe',labels = c('5.5-5.8','6.5-6.8','7.3-7.4','6.9-7.2'),
                      values = c('#2c7fb8','#9e9ac8','#addd8e','#bababa', '#ffffff')) + 
    theme_woodn() + 
    theme(axis.text.x = element_text(angle = -45, vjust = 1, hjust = 0.5)) 
    

# hypothesis testing
data.fft.4hr <- subset(data.fft,data.fft$time == '4hr')
dunn.test(data.fft.4hr$fft, data.fft.4hr$ph)

data.fft.12hr <- subset(data.fft,data.fft$time == '12hr')
dunn.test(data.fft.12hr$fft, data.fft.12hr$ph)
