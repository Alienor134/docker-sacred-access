import numpy as np
import pandas as pd

def merge_param_curve(df_param, df_curve, common_key, var_name, value_name, convert_log = True):
    # Melt df_curve to long format
    df_curve_long = df_curve.melt(id_vars=common_key, var_name=var_name, value_name=value_name)
    
    # Optional: convert 'time' from string to numeric
    if convert_log:
        df_curve_long[var_name] = np.log10(df_curve_long[var_name].astype(float))
    else:
        df_curve_long[var_name] = df_curve_long[var_name].astype(float)

    df_merged = pd.merge(df_curve_long, df_param, on=common_key, how='left')

    return df_merged



def log_sampling(y, N_log):
    N = len(y)
    ind= np.unique(np.logspace(np.log10(1), np.log10(N-1), N_log).astype(int))
    return ind