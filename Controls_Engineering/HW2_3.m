clear all
close all
format compact
x2 = linspace(-5,5,1000)
x1 = (x2(1:500).^2)/2 
x3=  -(x2(501:1000).^2)/2

x = [x1 x3]

plot(x2,x)