BAM_config.img_vault = 'F:\Preload\Img_vault\matfile_pool';
BAM_config.AO_dir = 'C:\Program Files (x86)\AlphaOmega\AlphaLab SNR System SDK\MATLAB_SDK';
BAM_data=[];




%% Electrode Setting
% by default, we got 2 channel at most, each chennel would have 1-4 sorted unit.
BAM_config.MaxElectrode = 2;
BAM_config.MaxUnit = 4;
for cc = 1:BAM_config.MaxElectrode
    for uu = 1:BAM_config.MaxUnit
        BAM_config.Electrode(cc,uu).Using = true;
        BAM_config.Electrode(cc,uu).UID = 0;
    end
    BAM_config.ElectrodeUsing(cc)=1;
end
BAM_config.num_unit_used = 0;


%% SR
% check whether this matchs AO logging file
BAM_config.SR.DIO=44000;
BAM_config.SR.SEG=44000;
BAM_config.SR.LFP=1375;
BAM_config.SR.AI=2750;

%% AO IP Address
BAM_config.IP.DSPMAC = 'A8:1B:6A:21:24:4B'; % Behind AO SnR
BAM_config.IP.PCMAC = 'bc:6a:29:e1:49:bf';% IP of online analysis PC
BAM_config.IP.Connected = 0;
BAM_config.IP.DeviceFreeMode=0; % Run this when you have no AO connected
BAM_config.IP.Buffered=0;

%%  about saving
BAM_config.is_saving=0;
BAM_config.save_interval = 5;
BAM_config.read_interval = 0.3;
BAM_config.combine_interval = 0.3;
% add channel
BAM_config.channelidarr = [10000,10128,10001,10129,11202,11016,11017,11020];
BAM_config.channel_name = {'lfp1','seg1','lfp2','seg2','eventcode','ai1','ai2','ai5'};


%% color parameters
BAM_config.colormap.red = [1,0,0];
BAM_config.colormap.green = [0,1,0];
BAM_config.colormap.blue = [0,0,1];
BAM_config.colormap.white = [1,1,1];
BAM_config.colormap.black = [0,0,0];
BAM_config.colormap.grey = [0.3,0.3,0.3];


save('default_params.mat',"BAM_config","BAM_data");
