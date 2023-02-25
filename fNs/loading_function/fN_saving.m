function [BAM_config,BAM_data, app] = fN_saving(BAM_config, BAM_data, app)
%%

    BAM_data.ChannelName={};

    %% adding event code
    BAM_data.interedted_channel_idx=fN_find_channel_idx(BAM_config,'eventcode');
    BAM_data.ChannelName{end+1} = 'EventCode';
    %% adding electrode, shall we change this to a function?
    if(app.ChannelUsingLFP1.Value)
        BAM_data.interedted_channel_idx=[BAM_data.interedted_channel_idx, fN_find_channel_idx(BAM_config,'lfp1'),fN_find_channel_idx(BAM_config,'seg1')];
        BAM_data.ChannelName{end+1} = 'LFP1';
        BAM_data.ChannelName{end+1} = 'SEG1';
    end
    if(app.ChannelUsingLFP2.Value)
        BAM_data.interedted_channel_idx=[BAM_data.interedted_channel_idx, fN_find_channel_idx(BAM_config,'lfp2'),fN_find_channel_idx(BAM_config,'seg2')];
        BAM_data.ChannelName{end+1} = 'LFP2';
        BAM_data.ChannelName{end+1} = 'SEG2';
    end
    %% adding AI data
    BAM_data.interedted_channel_idx=[BAM_data.interedted_channel_idx, fN_find_channel_idx(BAM_config,'ai1'),fN_find_channel_idx(BAM_config,'ai2')];
    BAM_data.ChannelName{end+1} = 'EYE1';
    BAM_data.ChannelName{end+1} = 'EYE2';
    %% asign info from config to data
    BAM_data.Electrode = BAM_config.Electrode;
    BAM_data.Dataset = app.SelectSet.Value;
    
    %% generate fake variable for storing data
    [BAM_data, max_save_memory] = fN_pre_register_data(BAM_config,BAM_data,app);

    % generate data capture table

    app.DataCapture.Data = table(BAM_data.ChannelName',zeros([1,length(BAM_data.interedted_channel_idx)])',zeros([1,length(BAM_data.interedted_channel_idx)])', max_save_memory','VariableNames',{'Channel','DataCapture', 'Valid Data','Memory'});

    pdata=zeros(length(BAM_data.interedted_channel_idx),20000);
    datacapture=zeros([1,length(BAM_data.interedted_channel_idx)]);
    datacapture_history = zeros([1,length(BAM_data.interedted_channel_idx)]);

    saving_time = GetSecs;
    load_interval_measure = GetSecs;
    AO_ClearChannelData();
    while(GetSecs-load_interval_measure<BAM_config.read_interval)    
    end
    load_interval_measure=GetSecs;
    delay_time = 0;


    while(1)
        if(app.StartOnlineSavingButton.Enable)
            disp('stopped')
            [BAM_data] = fN_save_file(BAM_config,BAM_data,app);
            break
        end
            tic
            for ii = 1:length(BAM_data.interedted_channel_idx)
                [~,pdata(ii,:),datacapture(ii)] = AO_GetChannelData(BAM_data.interedted_channel_idx(ii));
            end
            delay_time = delay_time + toc;

            AO_ClearChannelData();

            datacapture_history = max(datacapture_history,datacapture);

            [BAM_data, location_progress] = fN_minium_prep(BAM_config,BAM_data, pdata,datacapture);

            app.DataCapture.Data(:,2) = table(datacapture_history');
            app.DataCapture.Data(:,3) = table(location_progress');
            pause(BAM_config.read_interval/10)
            
            [BAM_config, BAM_data, app, new_dataset] = fN_update_dataset(BAM_config, BAM_data, app);
            if(new_dataset)
                while(GetSecs-load_interval_measure<BAM_config.read_interval)    
                end
                continue;
            end

        if(GetSecs-saving_time>BAM_config.save_interval)
            app.delay_measurement.Text = ['miss ' ,num2str(1000*delay_time), 'ms to read data for ' ,num2str(BAM_config.save_interval), 's'];
            [BAM_data] = fN_save_file(BAM_config,BAM_data,app);
            saving_time=GetSecs;
            delay_time=0;
        end

        while(GetSecs-load_interval_measure<BAM_config.read_interval)    
        end
        load_interval_measure=GetSecs;
    end
end

