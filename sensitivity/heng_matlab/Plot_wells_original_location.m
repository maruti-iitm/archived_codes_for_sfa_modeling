Well_add_120 = [6.81 119.90
55.00 85.91
65.12 85.93
60.07 88.75
60.21 94.47
50.13 77.11
70.00 77.26
45.19 68.49
55.06 68.39
64.97 68.59
75.11 68.69
50.06 59.83
59.99 60.00
70.24 59.70
80.05 60.00
65.06 51.29
85.06 51.29
69.94 42.61
80.09 42.46
60.19 78.06
58.67 75.60
61.60 75.79
74.80 52.08
73.59 49.73
76.55 49.76
113.31 119.90
40.14 59.97
35.07 51.17
54.99 51.18
40.30 42.70
50.03 42.38
60.16 42.60
45.10 52.38
43.67 49.63
46.61 49.74
6.81 13.39
45.27 55.89
113.32 13.40
60.11 83.76
75.31 55.99
45.21 94.47
40.00 85.91
35.13 77.11
30.19 68.49
25.14 59.97
20.07 51.17
15.26 42.54
80.12 85.93
85.00 77.26
90.11 68.69
95.05 60.00
100.06 51.29
104.04 42.92
30.26 32.54
40.30 32.70
50.03 32.38
60.16 32.60
69.94 32.61
80.09 32.46
89.04 32.92
30.26 22.54
40.30 22.70
50.03 22.38
60.16 22.60
69.94 22.61
80.09 22.46
89.04 22.92
30.26 12.54
40.30 12.70
50.03 12.38
60.16 12.60
69.94 12.61
80.09 12.46
89.04 12.92
30.26 109.47
40.30 109.47
50.03 109.47
60.16 109.47
69.94 109.47
80.09 109.47
89.04 109.47
75.21 94.47
];
x0 = 594239.42;
y0 = 115982.57;
theta = 35/180;
for i = 1:40
    well_orig(i,1) = cos(theta)*Well_add_120(i,1)-sin(theta)*Well_add_120(i,2)+x0;
    well_orig(i,2) = sin(theta)*Well_add_120(i,1)+cos(theta)*Well_add_120(i,2)+y0;
end
labels{1} = '1-60';
labels{2} = '2-07';
labels{3} = '2-08';
labels{4} = '2-09';
labels{5} = '2-10';
labels{6} = '2-11';
labels{7} = '2-12';
labels{8} = '2-13';
labels{9} = '2-14';
labels{10} = '2-15';
labels{11} = '2-16';
labels{12} = '2-17';
labels{13} = '2-18';
labels{14} = '2-19';
labels{15} = '2-20';
labels{16} = '2-21';
labels{17} = '2-22';
labels{18} = '2-23';
labels{19} = '2-24';
labels{20} = '2-26';
labels{21} = '2-27';
labels{22} = '2-28';
labels{23} = '2-29';
labels{24} = '2-30';
labels{25} = '2-31';
labels{26} = '2-33';
labels{27} = '3-23';
labels{28} = '3-24';
labels{29} = '3-25';
labels{30} = '3-27';
labels{31} = '3-28';
labels{32} = '3-29';
labels{33} = '3-30';
labels{34} = '3-31';
labels{35} = '3-32';
labels{36} = '3-34';
labels{37} = '3-35';
labels{38} = '3-37';
labels{39} = '2-34';
labels{40} = '2-37';
hold all;
plot(well_orig(1:40,1),well_orig(1:40,2),'ro');
set(gca,'fontsize',16)
text(well_orig(:,1), well_orig(:,2), labels, 'VerticalAlignment','bottom', ...
                             'HorizontalAlignment','right')
axis([594180 594370 115970 116160]);
xlabel('X (m)','fontsize',16);
ylabel('Y (m)','fontsize',16);