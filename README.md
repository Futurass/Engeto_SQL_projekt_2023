# Engeto_SQL_projekt_2023

Jméno studenta: Radomil Faksa

Kurz: Datová akademie ENGETO

---------------------------------------------------------------------------------------------------------------------------------------------------------------
Zadání projektu: 
Na vašem analytickém oddělení nezávislé společnosti, která se zabývá životní úrovní občanů, jste se dohodli, že se pokusíte odpovědět na pár definovaných výzkumných otázek, které adresují dostupnost základních potravin široké veřejnosti. Kolegové již vydefinovali základní otázky, na které se pokusí odpovědět a poskytnout tuto informaci tiskovému oddělení. Toto oddělení bude výsledky prezentovat na následující konferenci zaměřené na tuto oblast. Potřebují k tomu od vás připravit robustní datové podklady, ve kterých bude možné vidět porovnání dostupnosti potravin na základě průměrných příjmů za určité časové období. Jako dodatečný materiál připravte i tabulku s HDP, GINI koeficientem a populací dalších evropských států ve stejném období, jako primární přehled pro ČR.

Výzkumné otázky:
1) Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
2) Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
3) Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
4) Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
5) Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?
---------------------------------------------------------------------------------------------------------------------------------------------------------------

### VÝSTUP PROJEKTU:
#### Zkoumané období použito pro tento projekt je 2016 - 2018.

Mým výstupem z projektu jsou 2 nové tabulky, které slouží jako zdrojová data pro projekt a jedno na ně navázané view, které bylo použito u otázek 3 a 4:

1) t_radomil_faksa_project_SQL_primary_final = tabulka s informacemi o průměrných mzdách a průměrných cenách potravin za zkoumané období
2) t_radomil_faksa_project_SQL_secondary_final = tabulka s dodatečnými daty o dalších evropských státech
3) v_radomil_faksa_project_SQL = pomocné view pro porovnání cen potravin z tabulky t_radomil_faksa_project_SQL_primary_final


# Odpovědi na výzkumné otázky:
1) Ano, všude za pozorované období 2016 - 2018 mzdy rostou.
2) V prvním srovnatelném období (2016) by bylo možné za všechny průměrné mzdy koupit celkem cca 30 728 litrů mléka a cca 25 257 kg chleba. Pro poslední období (2018) by to bylo cca 31 726 litrů mléka a cca 25 940 kg chleba.
3) Nejpomaleji zdražuje za pozorované období 2016 - 2018 cukr krystalový, který od roku 2016 do 2018 ve výsledku zlevnil o cca 14,84 %. Pokud bychom šli ale po jednotlivých rocích, tak za 2016 - 2017 je "vítězem" mrkev (-23,41 %) a za 2017 - 2018 je to onen cukr (- 26,73 %)
4) Z použitých dat lze zjistit, že meziroční růst mezd o více jak 10 % byl pouze u dvou zaměstnání, a to v různých letech: "Ubytování, stravování a pohostinství" v letech 2016 - 2017 (růst o 10,16 %); "Kulturní, zábavní a rekreační činnosti" v letech 2017 - 2018 (růst o 10,14 %). Co se týká potravin, tak zde byl rozptyl meziročních cen dynamičtější. Růst o více jak 10 % byl zaznamenán v letech 2016 - 2017 u 5 potravin (Máslo = 25 % / Eidamská cihla = 22,22 % / Vejce slepičí čerstvá = 21,15 % / Cukr krystalový = 11,89 % / Pomeranče = 10,25 %) a v letech 2017 - 2018 pouze u jedné (Mrkev = 33,05 %)
5) Z pozorovaných dat za uvedené období se nepodařilo jednoznačně prokázat výrazný dopad růstu HDP na mzdy a ceny potravin. Výše růstu HDP byla pro období 2016 - 2017 ve výši cca 5 % a pro 2017 - 2018 ve výši cca 3 %. Všechny mzdy v pozorovaném období rostly (některé více a některé méně). Pro období 2016 - 2017 zachycen růst mezd od cca 4 % do cca 10 %, pro období 2017 - 2018 to bylo od cca 5 % do cca 10 %. Co se týká cen potravin, tak zde je rozptyl mnohem markantnější (některé zdražují a některé naopak zlevňují -> pro 2016 - 2017 je zachycen nejvyšší růst potraviny o cca 25 % a naopak největší zlevnění o cca 23 %; pro období 2017 - 2018 byl zachycen nejvyšší růst o cca 33 % a naopak největší zlevnění o cca 27 %.
