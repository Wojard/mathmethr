#' title: Анализ мощности
#' subtitle: Математические методы в зоологии с использованием R
#' author: Марина Варфоломеева

#' ## Пример: Снотворное
data(sleep)
View(sleep)

#' ## Двухвыборочный t-критерий
tt <- t.test(extra ~ group, sleep)
tt

#' ## Что спрятано в результатах?
str(tt)



#' ## A priori анализ мощности

#' ## Величина эффекта
library(pwr)
cohen.ES(test = "t", size = "large")

#' ## Задание
#' Рассчитайте величину умеренных и слабых эффектов для t-критерия









#' ## Величина эффекта из пилотных данных
alpha <- 0.05
power <- 0.80
sigma <- 27.7 # варьирование плотности халиотисов
diff <- 23.2 # ожидаемые различия плотности халиотисов
effect <- diff/sigma # величина эффекта
effect

#' ## Считаем объем выборки
pwr_hal <- pwr.t.test(n = NULL,
                      d = effect,
                      power = power,
                      sig.level = alpha,
                      type = "two.sample",
                      alternative = "two.sided")
pwr_hal


#' ## Задание
#' Рассчитайте сколько нужно обследовать проб, чтобы обнаружить слабый эффект с вероятностью 0.8, при уровне значимости 0.01
#' Вам понадобятся функции `cohen.ES()` и `pwr.t.test()`






#' ## Пример: Улитки на устрицах в мангровых зарослях (Minchinton, Ross, 1999)

#' ## Скачиваем данные с сайта
#' Не забудьте войти в вашу директорию для матметодов при помощи `setwd()`


library(downloader)
# в рабочем каталоге создаем суб-директорию для данных
if (!dir.exists("data")) dir.create("data")
# скачиваем файл либо в xlsx, либо в текстовом формате
if (!file.exists("data/minch.xlsx")) {
  download(
    url = "https://varmara.github.io/mathmethr/data/minch.xlsx",
    destfile = "data/minch.xlsx")
}
if (!file.exists("data/minch.csv")) {
  download(
    url = "https://varmara.github.io/mathmethr/data/minch.xls",
    destfile = "data/minch.csv")
}


#' ## Читаем данные из файла одним из способов

### Чтение из xlsx
library(readxl)
minch <- read_excel(path = "data/minch.xlsx", sheet = 1)

### Чтение из csv
minch <- read.table("data/minch.csv", header = TRUE)

## Знакомимся с данными
# Есть ли пропущенные значения?
sapply(minch, function(x) sum(is.na(x)))

# Каковы объемы выборок?
sum(!(is.na(minch$site == "A")))
sum(!(is.na(minch$site == "B")))

#' ## Боксплоты числа улиток
ggplot(data = minch, aes(x = site, y = limpt100)) +
  geom_boxplot() +
  labs(y = "Число улиток на 100 устриц",
       x = "Сайт")

ggplot(data = minch, aes(x = site, y = sqlim100)) +
  geom_boxplot() +
  labs(y = "Кв. корень из числа улиток на 100 устриц",
       x = "Сайт")

#' # A priory анализ мощности по данным пилотного исследования
#' ### Величина эффекта по исходным данным
library(effsize)
eff_snail <- cohen.d(minch$sqlim100, minch$site)
eff_snail
effect_snail <- abs(eff_snail$estimate)

#' ## Задание
#' Рассчитайте объем выборки, чтобы показать различия плотности улиток между сайтами с вероятностью 0.8?
#' Используйте функцию `pwr.t.test()`




#' ## Задание
#' Представьте, что в датасете __sleep__ содержатся данные пилотного исследования.
#' Оцените, какой объем выборки нужно взять, чтобы показать, что число часов дополнительного сна после применения двух препаратов различается?




