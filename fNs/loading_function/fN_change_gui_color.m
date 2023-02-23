function app = fN_change_gui_color(app,BAM_config,BAM_data)
%% about saving
% you dont need do modify this code when adding channel
if(BAM_config.is_saving)

    app.StartOnlineSavingButton.FontColor = BAM_config.colormap.white;
    app.StopOnlineSavingButton.FontColor = BAM_config.colormap.black;
    app.SavingLamp.Color=BAM_config.colormap.green;
    app.SavingLampLabel.Text='Saving';
    app.StartOnlineSavingButton.Enable=false;
    app.StopOnlineSavingButton.Enable=true;
else
    app.SavingLamp.Color=BAM_config.colormap.red;
    app.StartOnlineSavingButton.FontColor = BAM_config.colormap.black;
    app.StopOnlineSavingButton.FontColor = BAM_config.colormap.white;
    app.SavingLampLabel.Text='Stopped';
    app.StartOnlineSavingButton.Enable=true;
    app.StopOnlineSavingButton.Enable=false;
end

end
