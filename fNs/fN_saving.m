function [BAM_config,BAM_data, app] = fN_saving(BAM_config, BAM_data, app)
%%

    BAM_data.DigitalData={};BAM_config.DigitalNum=0;
    BAM_data.AnalogData={};BAM_config.AnalogNum=0;
    
    %% adding event code
    BAM_config.interedted_channel_idx=[fN_find_channel_idx(BAM_config,'eventcode')];
    big_ev_train=[];big_ev_time=[];
    
    if(app.ChannelUsingLFP1.Value)
        BAM_config.interedted_channel_idx=[BAM_config.interedted_channel_idx, fN_find_channel_idx(BAM_config,'lfp1'),fN_find_channel_idx(BAM_config,'seg1')];
    end
    if(app.ChannelUsingLFP2.Value)
        BAM_config.interedted_channel_idx=[BAM_config.interedted_channel_idx, fN_find_channel_idx(BAM_config,'lfp2'),fN_find_channel_idx(BAM_config,'seg2')];
    end

    
    pdata=zeros(length(BAM_config.interedted_channel_idx),20000);
    while(1)
        AO_ClearChannelData();
        pause(BAM_config.save_interval)
        if(strcmp(app.SavingLampLabel.Text,'Stopped'))
            disp('stopped')
            break
        end

        try
            tic
            for ii = 1:length(BAM_config.interedted_channel_idx)
                interested_channel = BAM_config.interedted_channel_idx(ii);
                [~,pdata(ii,:),datacapture(ii)] = AO_GetChannelData(interested_channel);
            end
            toc
        % the first is event code, dont change this!
        [ev_train,ev_time]=fN_sort_digital_port(pdata(1,:), datacapture(1));
        big_ev_train=[big_ev_train,ev_train];
        big_ev_time = [big_ev_time, ev_time];

        [~,time_now] = fN_sort_seg_port(pdata(3,:),datacapture(3));
        
        end

    end



end