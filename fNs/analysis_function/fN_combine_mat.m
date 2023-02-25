function [BAM_analysis, app]=fN_combine_mat(today_name,root_dir, app)
    BAM_analysis.folder_today = [root_dir, '/data/',today_name, '*'];
    BAM_analysis.all_session = dir(BAM_analysis.folder_today);
    
    for ses = 1:length(BAM_analysis.all_session)
        ses_folder = [BAM_analysis.all_session(ses).folder, '\', BAM_analysis.all_session(ses).name];
        all_uncheck = dir([ses_folder,'\uncheck*']);
    
        if(~isempty(all_uncheck))
            first_data = load([ses_folder,'\',all_uncheck(1).name]).BAM_data;
            BAM_analysis.dataset{ses} = [num2str(ses),'-',first_data.Dataset];
        end
        % combine..
    end

    app.SelectSession.Items = BAM_analysis.dataset;
    app.SelectSession.Value = BAM_analysis.dataset{ses};
    pause(0.05)
end