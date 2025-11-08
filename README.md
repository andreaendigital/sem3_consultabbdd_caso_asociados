# Caso de Estudio: ASOCIADOS Corredora de Propiedades

A partir de un caso planteado, tendrás que utilizar sentencias SQL (y Scripts) para realizar algunos reportes de interés, para obtener información de análisis en un formato y orden específico. 

## Descripción del Proyecto :scroll:

⭐⭐ Caso planteado: 

Hace 2 años un grupo de emprendedores crearon la empresa ASOCIADOS, dedicada preferentemente al arriendo de propiedades en la región metropolitana. Su sello ha sido la innovación en el rubro a partir de un servicio de arriendo profesional y capacitado, sustentado en pilares de gestión que aseguran una atención integral y de alto valor agregado a sus clientes. 
Debido a la calidad del servicio que prestan, se ha posicionado como la empresa líder en su rubro y de acuerdo con una proyección efectuada, se estima que, al finalizar el presente año, sus servicios se extenderán a todas las comunas de la región metropolitana y además, ampliará su gestión a cinco regiones en el país. 
El crecimiento exponencial de su cartera de clientes hizo necesario que ASOCIADOS cuente con un Sistema Informático robusto que apoye de manera eficiente su gestión, garantizando de esta manera la continuidad en la excelencia del servicio que presta. Este Sistema está siendo implementado por la empresa de soluciones informáticas SOLUINFO, en la cual tú trabajas, y se definieron tres etapas de entrega. 
La primera y segunda etapa del proyecto —ya finalizadas— consistieron en el modelado de la base de datos para satisfacer todos los requerimientos de información necesarios para una gestión eficiente de los ASOCIADOS, así como en la automatización del ingreso de datos de clientes y propiedades en arriendo. Además, se desarrollaron diversos informes que permiten controlar tanto las propiedades arrendadas como las disponibles, proporcionando información clave para respaldar las nuevas estrategias que la empresa desea implementar.
La tercera etapa, que está programada para comenzar en abril de este año, consistirá en la implementación de programas que permitan ejecutar tareas automáticas a solicitud del usuario.
En esta última fase del proyecto, serás responsable de dar solución a los requerimientos definidos por el usuario, los cuales se describen en los distintos casos planteados.

Paso 1: Creación y poblado de tablas del Modelo Relacional

<img width="1786" height="881" alt="Captura de pantalla 2025-11-08 173540" src="https://github.com/user-attachments/assets/fc660707-8975-4436-9dea-197b254aa8d2" />

El caso adjuntaba un script para la creación y poblamiento de tablas *

### ✨Requisitos   ✨

Paso 2: Casos
A continuación, se detallan los casos que debes completar:


👉 Caso 1: Listado de Clientes con Rango de Renta

Especificación de requerimientos o reglas

Asociados dentro de sus requerimientos contempla tener resúmenes comerciales de las propiedades de sus clientes.  Como empresa corredora de propiedades los informes comerciales de los registros que manejan son parte importante para la toma de decisiones, sobre todo para ofrecer productos a posibles clientes.
Por ello se requiere desarrollar un informe comercial cuyo fin es:
- Mostrar solo los clientes listados entre un rango de renta definido por el operario que interactúe con el informe, es decir, el desarrollo debe ser capaz de pedir el monto mínimo y máximo de renta a filtrar por pantalla.
- El reporte debe mostrar el RUT de los clientes con puntos y guion, y considerar solo a los clientes que tienen registrado un número de celular.
- El objetivo del informe es medir por tramos la rentabilidad de cada uno de los clientes, considerando la siguiente escala:
- Renta mayor de 500.000 clasifica como 'TRAMO 1'.
- Renta entre 400.000 y 500.000 clasifica como 'TRAMO 2'.
- Renta entre 200.000 y 399.999 clasifica como 'TRAMO 3'.
- Renta menor de 200.000 clasifica como 'TRAMO 4'.

👉 Caso 2: Sueldo Promedio por Categoría de Empleado.

Especificación de requerimientos o reglas

La empresa ASOCIADOS, dedicada a la gestión de propiedades y arriendos, está en proceso de optimizar su sistema de incentivos para clientes/arrendatarios. 
Como parte de esta iniciativa, el departamento de Recursos Humanos ha solicitado un informe que les permita identificar grupos de empleados por categoría.

Las categorías se clasifican por el siguiente código:
- 1 corresponde Gerente
- 2 corresponde Supervisor
- 3 corresponde Ejecutivo de Arriendo
- 4 corresponde Auxiliar

Al igual que el código de sucursal:
- 10 corresponde Sucursal Las Condes
- 20 corresponde Sucursal Santiago Centro
- 30 corresponde Sucursal Providencia
- 40 corresponde Sucursal Vitacura

De la cantidad de empleados por sucursal se debe calcular el promedio de sueldo y formatear con signo pesos separando miles.
Este reporte será utilizado por la gerencia para evaluar el impacto de la política de incentivos y considerar posibles ajustes en la estrategia de compensaciones, para ello el usuario podrá ingresar por pantalla el valor del sueldo promedio mínimo a considerar en el reporte.

👉Caso 3:Arriendo Promedio por Tipo de Propiedad

Especificación de Requerimientos o reglas

La empresa ASOCIADOS, en su compromiso con la fidelización de clientes, está desarrollando una estrategia para generar un informe agrupando los registros por tipo de propiedad que ellos tienen en sus registros. 
Deberá calcular indicadores clave, tales como el total de propiedades registradas, el promedio del valor de arriendo, de superficie y la razón de arriendo por metro cuadrado.  
Además, se espera que se transforme el código del tipo de propiedad en una descripción legible:
El reporte final deberá incluir, además de los indicadores anteriores, una clasificación de las propiedades basada en el valor de arriendo por metro cuadrado, asignando categorías como menor de 5.000 m2 es "Económico", entre 5.000 y 10.000 m2 "Medio" o superior a todos los anteriores "Alto", según los umbrales establecidos.
Cabe destacar que el reporte solo mostrará los registros cuyo promedio del valor de arriendo por m2 sea superior a 1.000.


Requerimientos Generales

A partir de lo expuesto anteriormente, construye la sentencia SQL considerando los siguientes requerimientos: 
- Debes considerar los alias de cada columna.
- Se deben respetar los formatos de cada columna de las FIguras que adjuntó el caso
- La sentencia SQL deberá contener: 
  o Funciones SQL de una fila: caracteres, numéricas, fecha, manejo de nulos, condicionales y/o conversión.
  o Funciones de grupo.
  o Grupo de datos y restricción de grupos de datos.
  o Cláusulas de ordenamiento
- No aplica el uso de la cláusula WITH.


## Solución planteada:

Caso 1

<img width="998" height="219" alt="Captura de pantalla 2025-11-08 172703" src="https://github.com/user-attachments/assets/43a1f0e8-ed97-46f6-9e2d-525fb3ff69d8" />

<img width="1012" height="203" alt="Captura de pantalla 2025-11-08 172715" src="https://github.com/user-attachments/assets/f7208486-9a7f-4626-8393-308987c88ed2" />

Caso 2

<img width="795" height="193" alt="Captura de pantalla 2025-11-08 172523" src="https://github.com/user-attachments/assets/d92fc8d0-5592-43f8-bdc7-f8820f9ebda7" />

Caso 3

<img width="974" height="117" alt="Captura de pantalla 2025-11-08 172454" src="https://github.com/user-attachments/assets/5b4f1ef3-5906-4d9d-9b74-e0178e13ffce" />


## Autora ⚡ 

- **Andrea Rosero** ⚡  - [Andrea Rosero](https://github.com/andreaendigital)
