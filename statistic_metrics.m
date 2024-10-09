data = readtable('z_geoportal_up42.csv');


% Usuwanie wierszy z NaN w kolumnach Z, geoportal1 i up421 (jednocześnie)
data_clean = rmmissing(data, 'DataVariables', {'Z', 'geoportal1', 'up421'});

% Oblicz różnice między kolumnami (data_clean, a nie data)
data_clean.Z_geoportal = data_clean.Z - data_clean.geoportal1;
data_clean.Z_up421 = data_clean.Z - data_clean.up421;
data_clean.geoportal_up421 = data_clean.geoportal1 - data_clean.up421;

% 1. MAE (Mean Absolute Error) - Średni Błąd Bezwzględny
MAE_geoportal = mean(abs(data_clean.Z_geoportal));
MAE_up421 = mean(abs(data_clean.Z_up421));

% 2. SD (Standard Deviation) - Odchylenie Standardowe
SD_geoportal = std(data_clean.Z_geoportal);
SD_up421 = std(data_clean.Z_up421);

% 3. Quantile (kwantyle dla różnic, np. 25%, 50%, 75%)
quantile_geoportal = quantile(data_clean.Z_geoportal, [0.25, 0.50, 0.75]);
quantile_up421 = quantile(data_clean.Z_up421, [0.25, 0.50, 0.75]);

% 4. ME (Mean Error) - Średni błąd (różnica)
ME_geoportal = mean(data_clean.Z_geoportal);
ME_up421 = mean(data_clean.Z_up421);

% 5. RMSE (Root Mean Square Error) - Błąd średniokwadratowy
RMSE_geoportal = sqrt(mean(data_clean.Z_geoportal.^2));
RMSE_up421 = sqrt(mean(data_clean.Z_up421.^2));

% Sprawdzenie warunku SD = RMSE, jeśli ME = 0
if ME_geoportal == 0
    disp('SD_geoportal = RMSE_geoportal');
else
    disp('SD_geoportal != RMSE_geoportal');
end

if ME_up421 == 0
    disp('SD_up421 = RMSE_up421');
else
    disp('SD_up421 != RMSE_up421');
end

% Wyświetlenie wyników
fprintf('MAE (geoportal): %.4f\n', MAE_geoportal);
fprintf('MAE (up421): %.4f\n', MAE_up421);

fprintf('SD (geoportal): %.4f\n', SD_geoportal);
fprintf('SD (up421): %.4f\n', SD_up421);

fprintf('Kwantyle (geoportal): 25%%: %.4f, 50%%: %.4f, 75%%: %.4f\n', quantile_geoportal);
fprintf('Kwantyle (up421): 25%%: %.4f, 50%%: %.4f, 75%%: %.4f\n', quantile_up421);

fprintf('ME (geoportal): %.4f\n', ME_geoportal);
fprintf('ME (up421): %.4f\n', ME_up421);

fprintf('RMSE (geoportal): %.4f\n', RMSE_geoportal);
fprintf('RMSE (up421): %.4f\n', RMSE_up421);

