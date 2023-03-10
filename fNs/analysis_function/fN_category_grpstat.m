function [combined_data, BAM_config, BAM_analysis, app] = fN_category_grpstat(combined_data, BAM_config, BAM_analysis, app);

img_idx=mod(combined_data.ev_train(combined_data.valid_onset), 10000);

grp_idx=[]; img_to_show = [];
for cc = 1:length(BAM_analysis.img_info.category.name)
    match_idx = (BAM_analysis.img_info.category.idx(img_idx)==cc);
    grp_idx(cc) = sum(match_idx);

%     try
%         first_img = find(match_idx);
%         first_img = first_img(1);
%         example_img = fullfile(BAM_analysis.img_info.image_info{img_idx(first_img),2},BAM_analysis.img_info.image_info{img_idx(first_img),1});
%         img_to_show = [img_to_show, imread(example_img)];
%     end
end
bar_plot = bar(app.CategoryGrpstat,grp_idx);
app.CategoryGrpstat.XTickLabel=BAM_analysis.img_info.category.name;
% 
% try
%     imagesc(app.example, img_to_show)
% add app.example to show examplar
% end

end