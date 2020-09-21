%function to parse element set epoch from TLE data text file

function [date,solar_time,daynum] = TLEepoch(path);
format shortg;
% %folder pathway
% folder=('C:\Users\jfuru\Desktop\UMD\Fall 2019\ENAE 441\assignments\TLE\');
% %file name
% file=('ISS 3.txt');
% %full pathway
% path=strcat(folder,file);
%open TLE file
fID = fopen(path,'r');
%read data from TLE txt file - Line 1
L1 = fgetl(fID);
%read element set epoch from TLE line 1
year=str2num(L1(19:20));
if year >= 57
    year=year+1900;
else
    year=year+2000;
end
YYYY=year;
%check for leap year
if rem(year,4)==0
    n_feb=29;
elseif rem(year,100)==0
    n_feb=28;
elseif rem(year,400)==0
    n_feb=29;
else
    n_feb=28;
end
%lengths of other months
[n_jan,n_mar,n_may,n_jul,n_aug,n_oct,n_dec]=deal(31);
[n_apr,n_jun,n_sep,n_nov]=deal(30);
%sequential day in the year
day=str2num(L1(21:23));
%convert sequential day to month+date format
if (1<=day)&&(day<=n_jan)
    %month='January';
    MM='01';
    DD=day;
elseif (n_jan<day)&&(day<=n_jan+n_feb)
    %month='February';
    MM='02';
    DD=day-31;
elseif (n_jan+n_feb<day)&&(day<=n_jan+n_feb+n_mar)
    %month='March';
    MM='03';
    DD=day-59;
elseif (n_jan+n_feb+n_mar<day)&&(day<=n_jan+n_feb+n_mar+n_apr)
    %month='April';
    MM='04';
    DD=day-90;
elseif (n_jan+n_feb+n_mar+n_apr<day)&&(day<=n_jan+n_feb+n_mar+n_apr+n_may)
    %month='May';
    MM='05';
    DD=day-120;
elseif (n_jan+n_feb+n_mar+n_apr+n_may<day)&&(day<=n_jan+n_feb+n_mar+n_apr+n_may+n_jun)
    %month='June';
    MM='06';
    DD=day-151;
elseif (n_jan+n_feb+n_mar+n_apr+n_may+n_jun<day)&&(day<=n_jan+n_feb+n_mar+n_apr+n_may+n_jun+n_jul)
    %month='July';
    MM='07';
    DD=day-181;
elseif (n_jan+n_feb+n_mar+n_apr+n_may+n_jun+n_jul<day)&&(day<=n_jan+n_feb+n_mar+n_apr+n_may+n_jun+n_jul+n_aug)
    %month='August';
    MM='08';
    DD=day-212;
elseif (n_jan+n_feb+n_mar+n_apr+n_may+n_jun+n_jul+n_aug<day)&&(day<=n_jan+n_feb+n_mar+n_apr+n_may+n_jun+n_jul+n_aug+n_sep)
    %month='September';
    MM='09';
    DD=day-243;
elseif (n_jan+n_feb+n_mar+n_apr+n_may+n_jun+n_jul+n_aug+n_sep<day)&&(day<=n_jan+n_feb+n_mar+n_apr+n_may+n_jun+n_jul+n_aug+n_sep+n_oct)
    %month='October';
    MM='10';
    DD=day-273;
elseif (n_jan+n_feb+n_mar+n_apr+n_may+n_jun+n_jul+n_aug+n_sep+n_oct<day)&&(day<=n_jan+n_feb+n_mar+n_apr+n_may+n_jun+n_jul+n_aug+n_sep+n_oct+n_nov)
    %month='November';
    MM='11';
    DD=day-304;
elseif (n_jan+n_feb+n_mar+n_apr+n_may+n_jun+n_jul+n_aug+n_sep+n_oct+n_nov<day)&&(day<=n_jan+n_feb+n_mar+n_apr+n_may+n_jun+n_jul+n_aug+n_sep+n_oct+n_nov+n_dec)
    %month='December';
    MM='12';
    DD=day-334;
end
%close TLE file
fclose(fID);
%convert date to string
DD=num2str(DD);
if strlength(DD)==1
    DD=strcat('0',DD);
else
    DD=DD;
end
YYYY=num2str(YYYY);
date=strcat(MM,'/',DD,'/',YYYY);
daynum=str2num(L1(21:32));
%convert day decimal to hh:mm:ss
day_dec=str2num(L1(24:32));
hours=day_dec*24;
hh=floor(hours);
minutes=(hours-hh)*60;
mm=floor(minutes);
seconds=(minutes-mm)*60;
ss=round(seconds);
%convert time to string
hh=num2str(hh);
if strlength(hh)==1
    hh=strcat('0',hh);
else
    hh=hh;
end
mm=num2str(mm);
if strlength(mm)==1
    mm=strcat('0',mm);
else
    mm=mm;
end
ss=num2str(ss);
if strlength(ss)==1
    ss=strcat('0',ss);
else
    ss=ss;
end
solar_time=strcat(hh,':',mm,':',ss);