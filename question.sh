#
#  LAB: Transformación de archivos con `sed`
#  ================================================
#
#  Una tarea común en Analytics es el procesamiento de archivos en bruto para que puedan 
#  ser usados en otros procesos, donde gran parte de dicho procesamiento corresponde a la 
#  transforamción del formato. Estos archivos suelen tener millones de registros por lo que 
#  la aplicación de procedimientos manuales no es práctica.
#  
#  El archivo `data.csv` contiene una muestra de los archivos generados automáticamente 
#  por un software. El archivo contiene cuatro (4) columnas, donde los valores válidos
#  para los campos son los siguientes:
#  
#  * Columna 1: `DD/MM/AA`.
#  * Columna 2: `A`, `B`, `C`. `\N` indica NULL.
#  * Columna 3: Número entero. `\N` indica NULL.
#  * Columna 4: Número decimal. `\N` indica NULL.
#  
#  
#  Usted debe escribir un script en bash que use sed para que realice 
#  las siguientes acciones:
#    
#  * Convierta el formato de las fechas de DD/MM/YY a YYYY-MM-DD.
#  
#  * Transforme el archivo para que todos los campos nulos aparezcan como `\N`.
#  
#  * Reemplace los `;` por `,`.
#  
#  * Use el `.` para indicar decimales.
#
#  El resultado del script se escribe en pantalla.
#
#  El programa se llamara por el evaluador tal como se indica a continuación:
#
#  $ bash question.sh data.csv > output.csv
#  
#  Rta/
#  2013-03-12,A,1,100.0
#  ...
#  2014-09-01,A,3,100.4
#
#  >>> Escriba su codigo a partir de este punto <<<
#
sed -e 's/\(^[0-9]\)\/\([0-9]\)/0\1\/0\2/' \  # Agrega un cero inicial a los días y meses de una sola cifra
    -e 's/\/\([0-9]\/\)/\/0\1/' \  # Agrega un cero inicial a los días y meses de una sola cifra en medio de la línea
    -e 's/\/\([0-9][0-9]\);/\/20\1;/' \  # Agrega '20' al año en formato YY
    -e 's/\([0-9][0-9]\)\/\([0-9][0-9]\)\/\([0-9][0-9]\)/20\3-\2-\1/g' \  # Cambia el formato de las fechas a YYYY-MM-DD
    -e 's/\(\\*[nN]\)/\\N/' \  # Reemplaza 'n' o 'N' con '\N' para representar valores nulos
    -e 's/\(;\)N/\;\\N/' \  # Reemplaza ';N' con ';\\N' para representar valores nulos
    -e 's/\(;;\)/;\N;/' \  # Agrega ';\\N' entre dos puntos y coma consecutivos
    -e 's|,|.|g' \  # Reemplaza las comas por puntos para representar decimales
    -e 's|;|,|g' \  # Reemplaza los puntos y comas por comas para separar los campos
    -e 's/,,/,\\N,/g' \  # Reemplaza dos comas consecutivas por ',\N,' para indicar valores nulos
    -e 's/n/N/g' \  # Reemplaza 'n' por 'N'
    -e 's/,N/,\\N/g' \  # Agrega escape a '\N' después de una coma
    -e 's/.*/\U&/' \  # Convierte el texto a mayúsculas
    -e 's/\//-/g' \  # Reemplaza las barras '/' por guiones '-'
    -e 's/,$/,\\N/g'  # Agrega escape a '\N' al final de la línea
    -e data.csv > output.csv









