clear all
close all

addpath('/Users/kjh60/Dropbox/BXD_lifespan_finder/');

data_frame_path='/Volumes/dusom_civm-kjh60/All_Staff/18.gaj.42/Dataframes/18.gaj.42_allspecimen_asof2024_03_21_dataframe.csv';
df=civm_read_table(data_frame_path);

for n=1:size(df,1)

    strain=df.subgroup1(n);

    temp=strsplit(char(strain),'BXD');

    if numel(temp)>1
        df.index_strain{n}=temp{2};
    end

    age_at_perfusion=df.age(n);
    [df.life_fraction(n)] = estimate_fraction_lifespan(strain,age_at_perfusion);
end

[k_clusteridx,k_centroids]=kmeans([df.age,df.life_fraction],2);

df.segmentation_age=k_clusteridx;

writetable(df,data_frame_path);