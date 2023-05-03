%%

position(isnan(position)) = 7000;

plunge_n = double(plunge_n);
Wn = 2*(2e3)/fs;
[b,a]=butter(3,Wn);
Wn2 = 2*(500)/fs;
[b2,a2]=butter(1,Wn2);
% [b, a] = butter(10, 60/5000, 'high');

Vp = 2.8 * Te_raw + Vf;
Vp = filtfilt(b,a,Vp);
Vp = smoothdata(Vp,"gaussian",200);
clear Er
for i = 1:plunge_n
    Er{2*i-1} = -gradient( Vp(plunge_index(3*i-2):plunge_index(3*i-1)),position(plunge_index(3*i-2):plunge_index(3*i-1)) );
    Er{2*i} = -gradient( Vp(plunge_index(3*i-1):plunge_index(3*i)),position(plunge_index(3*i-1):plunge_index(3*i)) );
%     Er{2*i-1} = filtfilt(b,a,Er{2*i-1});
%     Er{2*i} = filtfilt(b,a,Er{2*i});
end

figure

plot(position(plunge_index(3*i-2):plunge_index(3*i-1)),Er{2*i-1})
ylim([-1000 1000])

% IA_raw = IA;
% IB_raw = IB;

clear IA_offset IB_offset
for i = 1:11
    IA_offset(i) = mean(IA_raw(i,1:10000));
    IB_offset(i) = mean(IB_raw(i,1:10000));
%     IA_offset(i) = 0;
%     IB_offset(i) = 0;
%     IA_offset(i) = mean(IA{2*i}(1:10000));
%     IB_offset(i) = mean(IB{2*i}(1:10000));

end

figure
plot(IA_offset)
hold on
plot(IB_offset)

for i = 1:11
    IA(i,:) = filtfilt(b,a,IA_raw(i,:))-IA_offset(i);
    IB(i,:) = filtfilt(b,a,IB_raw(i,:))-IB_offset(i);
end


Isat = filtfilt(b,a,Isat);
ne = filtfilt(b2,a2,ne_raw);
Te = filtfilt(b2,a2,Te_raw);
pe = filtfilt(b2,a2,Te_raw .* ne_raw);