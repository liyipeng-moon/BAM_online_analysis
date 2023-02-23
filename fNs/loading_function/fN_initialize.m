function [BAM_config, BAM_data, app] = fn_initialize(app)

    load('default_params.mat')
    GAM_data=[];
    Wait_interval = 0.2;
    app.SavingLamp.Color=BAM_config.colormap.blue;
    BAM_config.is_saving = 0;
    wrong_txt=[];
    %% check what dataset we have
    try
        app.SavingLampLabel.Text='Load Dataset Success';
        all_dataset = dir([BAM_config.img_vault,'/*mat']);
        dataset_name = {};
        for ii = 1:length(all_dataset)
            dataset_name{end+1} = all_dataset(ii).name(1:end-4);
        end
        app.SelectSet.Items = dataset_name;
        app.SelectSet.Value = 'face';
        
        
        pause(Wait_interval)
    catch
        wrong_txt = 'Load Dataset Wrong';
    end

    %%
    app.SavingLampLabel.Text='Adding AO Path';
    addpath(genpath(BAM_config.AO_dir))
    %% set electrode
    [BAM_config BAM_data, app] = fN_assign_electrode(BAM_config, BAM_data, app);

    % set slectrode refresh step
%     for electrode = 1:BAM_config.MaxElectrode
%         for channel = 1:BAM_config.MaxUnit
%                 spinner_filed  = ['Spinners', num2str(electrode), num2str(channel)];
%                 temp = getfield(app, spinner_filed);
%                 temp.Step = BAM_config.MaxElectrode*BAM_config.MaxUnit;
%                 setfield(app,spinner_filed,temp)
%         end
%     end
    [BAM_config,BAM_data, app] = fN_ao_connect(BAM_config, BAM_data, app);
    if(~BAM_config.IP.Connected)
        wrong_txt='Fail to Connect to AO';
    end
    if(~BAM_config.IP.Buffered)
        wrong_txt='Fail to Buffer';
    end
    %%
    if(isempty(wrong_txt))
        % initialize success
        app.SavingLampLabel.Text='Wait to Srart! Lets do some science!' ;
        app.SavingLamp.Color = BAM_config.colormap.blue;
    else
        % display wrong info
        app.SavingLampLabel.Text=wrong_txt;
        app.SavingLamp.Color = BAM_config.colormap.white;
    end
    temp =  strrep(datestr(datetime), ' ', '_');
    BAM_config.today = [temp(1:11), '_ss_', num2str(app.SessionSpinner.Value)];
    
    mkdir(['data/' BAM_config.today])
end