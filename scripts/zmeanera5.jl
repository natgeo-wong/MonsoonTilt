using DrWatson
@quickactivate "MonsoonTilt"

global_logger(ConsoleLogger(stdout,Logging.Info))

era5matrix(modID="msfc",parID="prcp_tot")
era5matrix(modID="dpre",parID="t_air",pre=1000)
