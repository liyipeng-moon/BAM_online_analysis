function [BAM_config,BAM_data, app] = fN_saving(BAM_config, BAM_data, app)
%%

    BAM_data.DigitalData={};BAM_config.DigitalNum=0;
    BAM_data.AnalogData={};BAM_config.AnalogNum=0;
    
    %% adding event code
    BAM_config.interedted_channel_idx=[fN_find_channel_idx(BAM_config,'eventcode')];
    big_ev_train=[];big_ev_time=[];
    big_spk_train=[];big_spk_time=[];
    if(app.ChannelUsingLFP1.Value)
        BAM_config.interedted_channel_idx=[BAM_config.interedted_channel_idx, fN_find_channel_idx(BAM_config,'lfp1'),fN_find_channel_idx(BAM_config,'seg1')];
    end
    if(app.ChannelUsingLFP2.Value)
        BAM_config.interedted_channel_idx=[BAM_config.interedted_channel_idx, fN_find_channel_idx(BAM_config,'lfp2'),fN_find_channel_idx(BAM_config,'seg2')];
    end

    
    pdata=zeros(length(BAM_config.interedted_channel_idx),20000);
    datacapture=zeros([1,length(BAM_config.interedted_channel_idx)]);
    while(1)
        AO_ClearChannelData();
        pause(BAM_config.save_interval)
        if(app.StartOnlineSavingButton.Enable)
            disp('stopped')
            break
        end
        
        try
            for ii = 1:length(BAM_config.interedted_channel_idx)
                interested_channel = BAM_config.interedted_channel_idx(ii);
                [~,pdata(ii,:),datacapture(ii)] = AO_GetChannelData(interested_channel);
            end
            disp(datacapture(3))
%             for times = 1:10
%                 AO_ClearChannelData();
%                 pause(1)
%                 [~,pdata(times,:),datacapture(times)] = AO_GetChannelData(10000);
%                 [~,time_now(times)] = fN_sort_seg_port(pdata(times,:),datacapture(times));
%             end

        % the first is event code, dont change this!
        disp('saving')
tic
        [ev_train,ev_time]=fN_sort_digital_port(pdata(1,:), datacapture(1),BAM_config.SR.DIO);

        big_ev_train=[big_ev_train,ev_train];
        big_ev_time = [big_ev_time, ev_time];

        [spike_id, spike_time] = fN_sort_seg_port(pdata(3,:),datacapture(3),BAM_config.SR.SEG);
        big_spk_train = [big_spk_train,spike_id];
        big_spk_time = [big_spk_time,spike_time];

        temp =  strrep(datestr(datetime), ':', '_');

        file_name = ['data/',BAM_config.today, '/', temp(13:end),'.mat'];
        tic
        save(file_name,'big_ev_train','big_ev_time','big_spk_train','big_spk_time')
toc
        end

    end



end