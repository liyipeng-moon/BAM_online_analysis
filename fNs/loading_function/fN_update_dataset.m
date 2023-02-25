function [BAM_config, BAM_data, app, continue_flag] = fN_update_dataset(BAM_config, BAM_data, app)
    all_event = BAM_data.big_ev_train.val(1:BAM_data.big_ev_train.location-1);
    if(any(all_event>100 & all_event<600)) % check dataset
        temp_array = all_event((all_event>100 & all_event<600));
        temp_array = mod(temp_array,100);
        dataset_now = BAM_config.dataset_name{temp_array(1)};
        if(~strcmp(app.SelectSet.Value,dataset_now))
            [BAM_data] = fN_save_file(BAM_config,BAM_data,app);
            app.SelectSet.Value = dataset_now;
            app.SessionSpinner.Value = app.SessionSpinner.Value + 1;
            pause(0.05)
            [BAM_config, BAM_data, app] = fN_initialize(app,'not_all', BAM_config, BAM_data);
            [BAM_data, ~] = fN_pre_register_data(BAM_config,BAM_data,app);
            BAM_data.Dataset = dataset_now;
            continue_flag = 1;
        end
    end
    continue_flag = 0;
end