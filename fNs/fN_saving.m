function [BAM_config,BAM_data, app] = fN_saving(BAM_config, BAM_data, app)
%%

    BAM_data.ChannelName={};

    %% adding event code
    BAM_data.interedted_channel_idx=fN_find_channel_idx(BAM_config,'eventcode');
    BAM_data.ChannelName{end+1} = 'EventCode';
    %% adding electrode
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
    [BAM_data, max_save_memory] = fn_pre_register_data(BAM_config,BAM_data,app);

    % generate data capture table

    app.DataCapture.Data = table(BAM_data.ChannelName',zeros([1,length(BAM_data.interedted_channel_idx)])',zeros([1,length(BAM_data.interedted_channel_idx)])', max_save_memory','VariableNames',{'Channel','DataCapture', 'Valid Data','Memory'});

    
    pdata=zeros(length(BAM_data.interedted_channel_idx),20000);
    datacapture=zeros([1,length(BAM_data.interedted_channel_idx)]);
    datacapture_history = zeros([1,length(BAM_data.interedted_channel_idx)]);

    saving_time = GetSecs;
    while(1)
        if(app.StartOnlineSavingButton.Enable)
            disp('stopped')
            break
        end
        
        AO_ClearChannelData();

        pause(BAM_config.read_interval)

            for ii = 1:length(BAM_data.interedted_channel_idx)
                interested_channel = BAM_data.interedted_channel_idx(ii);
                [~,pdata(ii,:),datacapture(ii)] = AO_GetChannelData(interested_channel);
            end
            datacapture_history = max(datacapture_history,datacapture);

            [BAM_data, location_progress] = fN_minium_prep(BAM_config,BAM_data, pdata,datacapture);
            app.DataCapture.Data(:,2) = table(datacapture_history');
            app.DataCapture.Data(:,3) = table(location_progress');


        if(GetSecs-saving_time>BAM_config.save_interval)
            app.delay_measurement.Text = ['take ' ,num2str(GetSecs-saving_time), 's to read data for ' ,num2str(BAM_config.save_interval), 's'];
            temp =  strrep(datestr(datetime), ':', '_');
            file_name = ['data/',BAM_config.today, '/', temp(13:end),'.mat'];
            save(file_name,'BAM_data')
            BAM_data = fn_pre_register_data(BAM_config,BAM_data,app);
            saving_time=GetSecs;
        end

        end





end