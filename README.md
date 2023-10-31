# Engeto_SQL_projekt_2023

#### Jméno studenta: Radomil Faksa
#### Discord: Radomil F.
#### Kurz: Datová akademie ENGETO

---------------------------------------------------------------------------------------------------------------------------------------------------------------
### ZADÁNÍ PROJEKTU: 
Na vašem analytickém oddělení nezávislé společnosti, která se zabývá životní úrovní občanů, jste se dohodli, že se pokusíte odpovědět na pár definovaných výzkumných otázek, které adresují dostupnost základních potravin široké veřejnosti. Kolegové již vydefinovali základní otázky, na které se pokusí odpovědět a poskytnout tuto informaci tiskovému oddělení. Toto oddělení bude výsledky prezentovat na následující konferenci zaměřené na tuto oblast. Potřebují k tomu od vás připravit robustní datové podklady, ve kterých bude možné vidět porovnání dostupnosti potravin na základě průměrných příjmů za určité časové období. Jako dodatečný materiál připravte i tabulku s HDP, GINI koeficientem a populací dalších evropských států ve stejném období, jako primární přehled pro ČR.

#### Výzkumné otázky:
1) Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
2) Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
3) Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
4) Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
5) Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?
---------------------------------------------------------------------------------------------------------------------------------------------------------------

### VÝSTUP PROJEKTU:
#### Zkoumané období použito pro tento projekt je 2006 - 2018.

Mým výstupem z projektu jsou 2 nové tabulky, které slouží jako zdrojová data pro projekt a 2 na ně navázaná view, která byla použita u otázek 3, 4 a 5:

1) t_radomil_faksa_project_SQL_primary_final = tabulka s informacemi o průměrných mzdách a průměrných cenách potravin za zkoumané období
2) t_radomil_faksa_project_SQL_secondary_final = tabulka s dodatečnými daty o dalších evropských státech
3) v_radomil_faksa_project_SQL_prices = pomocné view pro porovnání cen potravin
4) v_radomil_faksa_project_SQL_payrolls = pomocné view pro porovnání průměrů mezd

#### Odpovědi na výzkumné otázky:
1) Ne, za pozorované období 2006 - 2018 se vyskytují obory, u kterých je v některých letech zachycen pokles.
2) V prvním srovnatelném období (2006) by bylo možné v průměru koupit celkem cca 1 466 litrů mléka a cca 1 313 kg chleba. Pro poslední období (2018) by to bylo cca 1 670 litrů mléka a cca 1 365 kg chleba.
3) Nejpomaleji zdražují za pozorované období 2006 - 2018 Rajská jablka červená kulatá a nejvíce Těstoviny vaječné.
4) Z použitých dat lze zjistit, že meziroční růst cen potravin o více jak 10 % byl zachycen od roku 2006 do 2018 celkem 45-krát, a to v různých rocích i u různých potravin. Co se týká mezd, tak růst větší než 10% byl zachycen celkem 5-krát.
5) Za pozorované období HDP v ČR každým rokem rostlo (v rozptylu od cca 2 % do cca 5,5%) jen s rozdílem 3 let, kde je evidován pokles/stagnace: 2008 (cca - 4,5 %) , 2011 (- cca 1%) a 2012 (cca 0%). Co se týká vlivu změn HDP na mzdy/ceny, tak v roce 2008/2009 bychom mohli hovořit o potenciální reflexi, jelikož ceny potravin v průměru klesly o 8,21 %. Pokud ale porovnáme roky 2011 - 2013, kdy HDP klesalo/stagnovalo, tak ceny potravin jsou zde ale v růstu o 5,9 % (2011 - 2012) a 4,65 % (2012 - 2013). Následně ceny ročně po dobu 3 let v průměru klesají o cca 1 - 1,5%, ale HDP tyto roky naopak roste. Co se týká růstu mezd, tak ty v průměru rostou vždy (2006 - 2008 každoročně růst o cca 6,5 % || 2008 - 2015 každoročně růst cca 2 - 2,5 % s výjimkou roku 2012 - 2013, kdy byl celkově jediný pokles o cca 1 % || 2015 - 2018 každoročně růst o cca 4 - 7 % ). Z pozorovaných dat se za uvedené období nepodařilo jednoznačně prokázat výrazný dopad růstu HDP na mzdy a ceny potravin.
