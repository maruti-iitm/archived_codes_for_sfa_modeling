# the v1 version is written by Xuehang Song on 03/23/2018
# ----------------------------------------------------------
# v2 plot the direct data of flux, instead of intepolated flux
# v2 plot volumetric flux, instead of darcy flux
# revised by Xuehang 03/25/2018
# the v4 version is rewised by Xuehang Song on 04/11/2018
# ----------------------------------------------------------

import pickle
import matplotlib.pyplot as plt
import numpy as np
import matplotlib.gridspec as gridspec
from datetime import datetime, timedelta


def batch_time_to_delta(origin, x, time_format):
    y = []
    for ix in x:
        temp_y = abs(datetime.strptime(
            ix, time_format) - origin).total_seconds()
        y.append(temp_y)
    y = np.asarray(y)
    return(y)


def batch_delta_to_time(origin, x, time_format, delta_format):
    y = []
    for ix in x:
        if delta_format == "hours":
            temp_y = origin + timedelta(hours=ix)
        elif delta_format == "days":
            temp_y = origin + timedelta(days=ix)
        elif delta_format == "minutes":
            temp_y = origin + timedelta(minutes=ix)
        elif delta_format == "weeks":
            temp_y = origin + timedelta(weeks=ix)
        elif delta_format == "seconds":
            temp_y = origin + timedelta(seconds=ix)
        elif delta_format == "microseconds":
            temp_y = origin + timedelta(microseconds=ix)
        elif delta_format == "milliseconds":
            temp_y = origin + timedelta(milliseconds=ix)
        else:
            print("Sorry, this naive program only solve single time unit")
        y.append(temp_y.strftime(time_format))
    y = np.asarray(y)
    return(y)


output_dir = "/Users/song884/remote/reach/Outputs/HFR_100x100x5_6h_bc/"
pt_fname = output_dir + "face_flux.pk"

fig_dir = "/Users/song884/remote/reach/figures/" + \
    "HFR_100x100x5_6h_bc/face_flux/"
data_dir = "/Users/song884/remote/reach/data/"

discharge_file = open(data_dir + "USGS_flow_gh_12472800.csv", "r")
discharge_data = discharge_file.readlines()
discharge_data = [x.replace('"', "") for x in discharge_data]
discharge_data = [x.split(",") for x in discharge_data[1:]]
discharge_data = [list(filter(None, x)) for x in discharge_data]
discharge_data = np.asarray(discharge_data)
discharge_time = [datetime.strptime(x, "%Y-%m-%d")
                  for x in discharge_data[:, 3]]
discharge_value = discharge_data[:, 4]  # .astype(float)


pickle_file = open(pt_fname, "rb")
out_flux = pickle.load(pickle_file)
times = np.sort(list(out_flux.keys()))
simu_time = np.sort([np.float(i[5:19]) for i in times])

date_origin = datetime.strptime("2007-03-28 00:00:00", "%Y-%m-%d %H:%M:%S")
real_time = batch_delta_to_time(
    date_origin, simu_time, "%Y-%m-%d %H:%M:%S", "hours")
real_time = [datetime.strptime(x, "%Y-%m-%d %H:%M:%S") for x in real_time]

time_ticks = [
    "2011-01-01 00:00:00",
    "2012-01-01 00:00:00",
    "2013-01-01 00:00:00",
    "2014-01-01 00:00:00",
    "2015-01-01 00:00:00",
    "2016-01-01 00:00:00"]
time_ticks = [datetime.strptime(x, "%Y-%m-%d %H:%M:%S") for x in time_ticks]

n_segment = len(time_ticks) - 1
sum_flow = np.array([0.] * n_segment)
abs_flow = np.array([0.] * n_segment)
out_flow = np.array([0.] * n_segment)
in_flow = np.array([0.] * n_segment)
for i_segment in range(n_segment):
    select_index = []
    for i_index in range(len(real_time)):
        if (real_time[i_index] >= time_ticks[i_segment] and
                real_time[i_index] < time_ticks[i_segment + 1]):
            select_index.append(i_index)
    for i_index in select_index:
        temp_flux = np.asarray(out_flux[times[i_index]])
        sum_flow[i_segment] = sum_flow[i_segment] + np.sum(temp_flux)
        abs_flow[i_segment] = abs_flow[i_segment] + np.sum(np.abs(temp_flux))
        out_flow[i_segment] = out_flow[i_segment] + \
            sum(temp_flux[temp_flux >= 0])
        in_flow[i_segment] = in_flow[i_segment] + \
            sum(temp_flux[temp_flux <= 0])
    sum_flow[i_segment] = sum_flow[i_segment] / len(select_index)
    abs_flow[i_segment] = abs_flow[i_segment] / len(select_index)
    out_flow[i_segment] = out_flow[i_segment] / len(select_index)
    in_flow[i_segment] = in_flow[i_segment] / len(select_index)

sum_flow = sum_flow * 365.25 * 24
abs_flow = abs_flow * 365.25 * 24
out_flow = out_flow * 365.25 * 24
in_flow = in_flow * 365.25 * 24

discharge_flow = np.array([0.] * n_segment)
for i_segment in range(n_segment):
    select_index = []
    for i_index in range(len(discharge_time)):
        if (discharge_time[i_index] >= time_ticks[i_segment] and
                discharge_time[i_index] < time_ticks[i_segment + 1]):
            select_index.append(i_index)
    sum_discharge = sum(np.asarray([discharge_value[i]
                                    for i in select_index]).astype(float))
    sum_discharge = sum_discharge * 3600 * 24 * (0.3048**3)
    discharge_flow[i_segment] = sum_discharge

start_year = 2011
fig_name = fig_dir + "flux_bar.png"
gs = gridspec.GridSpec(1, 5)
fig = plt.figure()

ax0 = fig.add_subplot(gs[0, 0])
ax0.bar(start_year + np.arange(n_segment), discharge_flow, color="black")
ax0.set_ylim([0, 1.5e11])
ax0.set_xlabel('Time (year)')
ax0.set_ylabel('River Discharge ($m^3$/year)')
ax0.set_title("(a) Priest Rapid Dam Discharge", y=1.05)

ax1 = fig.add_subplot(gs[0, 1])
ax1.bar(start_year + np.arange(n_segment), out_flow, color="red")
ax1.set_ylim([0, 8e8])
ax1.set_xlabel('Time (year)')
ax1.set_ylabel('Exchange flux ($m^3$/year)')
ax1.set_title("(b) River Gaining Volume", y=1.05)

ax2 = fig.add_subplot(gs[0, 2])
ax2.bar(start_year + np.arange(n_segment), -in_flow, color="blue")
ax2.set_ylim([0, 8e8])
ax2.set_xlabel('Time (year)')
ax2.set_ylabel('Exchange flux ($m^3$/year)')
ax2.set_title("(c) River Losing Volume", y=1.05)

ax3 = fig.add_subplot(gs[0, 3])
ax3.bar(start_year + np.arange(n_segment), sum_flow, color="purple")
ax3.set_ylim([0, 8e8])
ax3.set_xlabel('Time (year)')
ax3.set_ylabel('Exchange flux ($m^3$/year)')
ax3.set_title("(d) River Net Gaining Volume", y=1.05)

ax4 = fig.add_subplot(gs[0, 4])
ax4.bar(start_year + np.arange(n_segment), abs_flow, color="brown")
ax4.set_ylim([0, 8e8])
ax4.set_xlabel('Time (year)')
ax4.set_ylabel('Exchange flux ($m^3$/year)')
ax4.set_title("(e) Abosulte Exchange", y=1.05)

fig.tight_layout()
fig.subplots_adjust(left=0.1,
                    right=0.95,
                    bottom=0.07,
                    top=0.85,
                    wspace=0.30,
                    hspace=0.38
                    )
fig.set_size_inches(20, 3.2)
fig.savefig(fig_name, dpi=600, transparent=True)
plt.close(fig)


bar_file = open(output_dir + "flux_net_gain.txt", 'w')
for i_flow in sum_flow:
    bar_file.write("%3.2e\n" % i_flow)
bar_file.close()

bar_file = open(output_dir + "flux_abs_exchange.txt", 'w')
for i_flow in abs_flow:
    bar_file.write("%3.2e\n" % i_flow)
bar_file.close()

bar_file = open(output_dir + "flux_lose.txt", 'w')
for i_flow in in_flow:
    bar_file.write("%3.2e\n" % -i_flow)
bar_file.close()

bar_file = open(output_dir + "flux_gain.txt", 'w')
for i_flow in out_flow:
    bar_file.write("%3.2e\n" % i_flow)
bar_file.close()

# select_flux = []
# select_flux = np.asarray(select_flux) / 3600 / 250 / 250
