# HDHR tuner scan

### What:
A command line utility to scan a HDHomeRun tuner and report the channels found

### Contents:
* channel_scan.sh and channel_report.sh from https://github.com/shmick/TV_Stuff

### Usage:
In order for hdhomerun_config to discover the HDHR Tuners on the network, the container needs to use [host networking](https://docs.docker.com/network/host/)

Auto discovery is not possible with Docker on MacOS, so an IP of a tuner will need to be used.

#### Run a scan (default behaviour)
```bash
$ docker run --network host ghcr.io/shmick/hdhomerun-scan
```

#### Run a scan using the IP of a tuner
```bash
$ docker run ghcr.io/shmick/hdhomerun-scan channel_scan.sh -d <IP of HDHR>
```

#### Log the results to a CSV file

```bash
$ docker run -v $HOME:/app/data ghcr.io/shmick/hdhomerun-scan channel_scan.sh -d 192.168.1.31 -l data/homerunlog.csv
```

#### Run a report on the CSV file
```bash
$ docker run -v $HOME:/app/data ghcr.io/shmick/hdhomerun-scan channel_report.sh data/homerunlog.csv

Timestamp		    RF	Strngth	dBmV	dBm	   Quality Symbol  Virtual	Name
----------------------------------------------------------------------------------
2020-07-04 18:41	8	100	    0   	-48.75	98	    100	    9.1	    CFTO
2020-07-04 18:41	15	81	    -11.4	-60.15	81	    100	    11.1	CHCH-DT
2020-07-04 18:41	16	80	    -12 	-60.75	78	    100	    49.1	MyTV
2020-07-04 18:41	17	100	    0	    -48.75	90	    100	    41.1	CIII
2020-07-04 18:41	18	100	    0   	-48.75	98	    100	    57.1	CITYTV
2020-07-04 18:41	19	100	    0	    -48.75	90	    100	    19.1	TVO
2020-07-04 18:41	20	100	    0	    -48.75	98	    100	    5.1	    CBLT-DT
2020-07-04 18:41	21	76	    -14.4	-63.15	76	    100	    8.1	    WROC-HD
2020-07-04 18:41	22	76	    -14.4	-63.15	68	    100	    21.1	WXXI-HD
2020-07-04 18:41	23	62	    -22.8	-71.55	52	    100	    56.1	WBXZLD1
2020-07-04 18:41	24	100	    0   	-48.75	100	    100	    51.1	ION
2020-07-04 18:41	25	100	    0   	-48.75	98	    100	    25.1	CBLFTDT
2020-07-04 18:41	26	85	    -9	    -57.75	52	    100	    40.1	CJMT
2020-07-04 18:41	28	68	    -19.2	-67.95	62	    100	    31.1	FOX
2020-07-04 18:41	30	100	    0   	-48.75	90	    100	    47.1	CFMT
2020-07-04 18:41	31	100	    0	    -48.75	100	    100	    17.1	WNED-HD
2020-07-04 18:41	32	100	    0   	-48.75	100	    100	    29.1	FOX
2020-07-04 18:41	33	100	    0	    -48.75	98	    100	    2.1	    WGRZ-HD
2020-07-04 18:41	34	87	    -7.8	-56.55	81	    100	    7.1 	WKBW-HD
2020-07-04 18:41	36	85	    -9	    -57.75	85	    100	    23.1	WNLO-HD

20 channels found
```


### Output:
```text
Beginning scan on <tuner>, tuner 0 at <date>

21 channels found
RF	Strnght	Quality	    Symbol	   Virtual	Name		Virt#2	Name
------------------------------------------------------------------------
8	100	98	100	9.1	    CFTO															
14	81	46	100	14.1	CITS-HD															
15	83	85	100	11.1	CHCH-DT															
16	93	98	100	49.1	MyTV		49.2	Stadium		49.3	Comet		49.4	GetTV						
17	100	100	100	41.1	CIII															
18	100	98	100	57.1	CITYTV															
19	100	100	100	19.1	TVO															
20	100	100	100	5.1	    CBLT-DT															
21	75	76	100	8.1	    WROC-HD		8.2	    BOUNCE		8.3	    Laff		8.4	    Escape						
22	75	63	100	21.1	WXXI-HD		21.2	WXXI-W		21.3	WXXI-C		21.4	WXXI-K		0				
23	63	54	100	56.1	WBXZLD1		56.2	Retro		56.3	JWLRY		56.4	ThroBak		56.5	Buzzr		56.6	Sonlife
24	100	100	100	51.1	ION		    51.2	qubo		51.3	IONPlus		51.4	Shop		51.5	QVC		51.6	HSN
25	100	98	100	25.1	CBLFTDT															
26	89	64	100	40.1	CJMT															
28	66	58	100	31.1	FOX		    31.2	Antenna		31.3	Comet		31.4	TBD						
30	100	98	100	47.1	CFMT															
31	100	100	100	17.1	WNED-HD		17.2	Create		17.3	KIDs		0							
32	100	100	100	29.1	FOX		    29.2	TBD		    29.3	Charge									
33	100	98	100	2.1	    WGRZ-HD		2.2	    Antenna		2.3	    Justice		2.4	Quest						
34	98	98	100	7.1	    WKBW-HD		7.2	    LAFF		7.3	    ESCAPE		7.4	Grit						
36	87	61	100	23.1	WNLO-HD		23.2	Bounce		4.1	    WIVB-HD		4.2	CourtTV						
```
