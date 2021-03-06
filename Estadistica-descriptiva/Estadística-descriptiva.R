# INFERENCIA ESTAD�STICA
# ESTAD�STICA DESCRIPTIVA
# Profesor: Gonzalo Perez de la Cruz
# Ayudantes: Dioney Alonso Rosas Sanchez
#            Juan Andr�s Cervantes Sandoval

# Esta clase estar� enfocada al an�lisis exploratorio
# y descriptivo de una base de datos real, con la finalidad
# que el estudiante pueda ENTENDER mejor los conceptos y
# t�cnicas estad�sticas que se han definido hasta el momento.

# libraries que se utilizar�n:
#install.packages("modeest")

library(readr) #para utilizar la funci�n read_csv
library(modeest) #para calcular la moda


######################EJEMPLO SENCILLO CON VARIABLES CONTINUAS EN VECTOR#########
#DATOS DE MENDENHALL, ejercicio 1.25
#Los siguientes datos dan los tiempos en segundos de falla para n = 88 
#transmisores-receptores de radio:

tfalla<-c(16, 224, 16, 80, 96, 536, 400, 80,
         392, 576, 128, 56, 656, 224, 40, 32,
         358, 384, 256, 246, 328, 464, 448, 716,
         304, 16, 72, 8, 80, 72, 56, 608,
         108, 194, 136, 224, 80, 16, 424, 264,
         156, 216, 168, 184, 552, 72, 184, 240,
         438, 120, 308, 32, 272, 152, 328, 480,
         60, 208, 340, 104, 72, 168, 40, 152,
         360, 232, 40, 112, 112, 288, 168, 352,
         56, 72, 64, 40, 184, 264, 96, 224,
         168, 168, 114, 280, 152, 208, 160, 176)


mean(tfalla) # calculo de la media
median(tfalla) # calculo de la mediana 
mfv(tfalla) # calculo de la moda 
var(tfalla) # varianza
sd(tfalla) # desviaci�n estandar 

min(tfalla) # primer estad�stico de orden
max(tfalla) #m�ximo estad�stico de orden
(rango= max(tfalla)-min(tfalla)) #rango de valores 


###################EJEMPLO CON MULTIPLES VARIABLES EN DATA FRAME################

# Cargamos nuestra base de datos, para esto debemos revisar que R
# est� tomando como directorio la carpeta donde est� guardada nuestra base.

datos = read_csv("titanic.csv") # guardamos en una variable "datos"


str(datos) # Para comprender la estructura de la base de datos
View(datos) # Visualizamos los datos


## MEDIDAS DE TENDENCIA CENTRAL
# Cantidades que buscan representar un valor central del conjunto de datos.
# Entre ellas se encuentran la media, mediana y moda.

mean(datos$Fare) # calculo de la media
median(datos$Fare) # calculo de la mediana 

## para la moda es necesario llamar al paquete "modeest"

mfv(datos$Fare) # sin embargo al trabajar con variables 
               #continuas �sta medida no nos aporta mucha informaci�n

## MEDIDAS DE DISPERSI�N
# Cantidades que buscan medir de alguna forma el grado de dispersi�n
# o separaci�n entre los datos. Entre ellas se encuentran la varianza, 
# desviaci�n est�ndar, estad�sticos de orden y rango.

var(datos$Fare) # varianza
sd(datos$Fare) # desviaci�n estandar 


min(datos$Fare) # primer estad�stico de orden
max(datos$Fare) # n-esimo estad�stico de orden 

(rango =  max(datos$Fare) - min(datos$Fare)) # rango 

# MEDIDAS DE FORMA
# Cantidades que buscan describir la "forma" en que se distribuyen los datos.

# Coeficiente de asimetr�a/sesgo
# Negativo: Sesgo a la izquierda, lo cual quiere decir que la cola de la 
# distribuci�n est� cargada a la izquierda
# Positivo: Sesgo a la derecha.

skewness=function(x) {
  m3=mean((x-mean(x))^3)
  skew=m3/(sd(x)^3)
  skew}

skewness(datos$Fare) # asimetr�a positivo (sesgo a la derecha)
# es decir, hay una cola m�s alargada a la derecha

# Coeficiente de curtosis k
# Leptoc�rtica (k>0): Decaimiento r�pido, colas ligeras (Picuda).
# Mesoc�rtica (k=0): Curva normal.
# Platic�rtica (k<0): Decaimiento lento, colas amplias (Aplanada).

curtosis=function(x) {
  m4=mean((x-mean(x))^4) 
  curt=m4/(sd(x)^4)-3  
  curt}

  
curtosis(datos$Fare) # positiva entonces es leptocurtica 
              

# CUANTILES
# Consideremos los datos ordenados de menor a mayor conservando las repeticiones.
sort(datos$Fare)

# Un cuantil es un n�mero que separa a los datos en dos partes: un cierto
# porcentaje de los datos son menores o iguales al cuantil y el porcentaje
# complementario corresponde a datos que son mayores o iguales al cuantil.
# en R se utliza la funci�n quantile().

# Ejemplo:
# La mediana es el cuantil cuya proporci�n de datos a la izquierda de �l
# es el 50% al igual que a la derecha
median(datos$Fare)
quantile(datos$Fare,.5)

# Observaci�n: el cuantil no es necesariamente �nico y pueden existir diversas
# formas de calcularlo, para m�s info utilizar help(quantile).

# Hay cuantiles que reciben nombres m�s espec�ficos: percentiles, deciles,
# cuartiles.


#calulemos los percentiles
quantile(datos$Fare,probs=seq(0,1,.01))

#calculemos los deciles 

quantile(datos$Fare,probs=seq(0,1,.1))

#calculemos los cuartiles

quantile(datos$Fare,probs=seq(0,1,.25))


# En R existe una funci�n muy importante llamada summary(), la cual
# nos arroja:

summary(datos$Fare)

# Notemos que con este comando, podemos hacer un resumen
# tanto de cuartiles, como de tendencia central y medidas 
# de dispersi�n



#DATOS CATEG�RICOS
#Podemos ver la frecuencia absoluta de cada categor�a de alguna variable discreta
#de nuestro Data Frame (o vector) usando la funci�n table
table(datos$Sex)
table(datos$Pclass)
table(datos$Survived)

#Esta funci�n usa libreria (gmodels), es muy �til para ver la frecuncia 
#absoluta, relativa y ver cruces con otras variables

CrossTable(datos$Sex) #frecuencia absoluta y relativa
CrossTable(datos$Sex,datos$Survived, prop.t=F,prop.chisq=F) 
#Cruce de frecuencias de sexo y sobrevivencia
#Hace pruebas de independencia entre variables, eso no lo veremos por ahora



#Datos continuos a categ�ricos
#De esta forma podemos crear otra variable dentro del data frame
#cut categoriza (divide) los datos continuos en grupos, haciendo una variable discreta
#seq nos dice en cuantos grupos se divide, rigth=FALSE es para que tome el primer valor

datos$Fare_cat<- cut(datos$Fare, seq(0,550,50),right=FALSE)
table(datos$Fare_cat)

