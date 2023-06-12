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
# Se utiliza el comando sed para realizar las transformaciones en los datos del archivo data.csv
cat data.csv |

# Agrega '20' al año en formato YY
sed 's/\/\([0-9][0-9]\);/\/20\1;/'  |

# Cambia el orden de la fecha a DD-MM-YYYY
sed 's/\([0-9]*\)\/\([0-9]*\)\/\([0-9]*\);/\3\/\2\/\1;/'  |

# Esta expresión agrega un cero al número de mes si solo tiene un dígito.
sed 's/\/\([0-9]\)\//\/0\1\//'  |

# Esta expresión agrega un cero al número de día si solo tiene un dígito.
sed 's/\/\([0-9]\);/\/0\1;/'  |

# Reemplaza las comas por puntos para representar decimales
sed 's/,/\./g'  |

# Reemplaza los puntos y comas por comas para separar los campos
sed 's/;/,/g'  |

# Reemplaza dos comas consecutivas por ',\\N,' para indicar valores nulos
sed 's/,,/,\N,/g'  |

# Reemplaza 'n' o 'N' con '\N' para representar valores nulos
sed 's/n/\\N/g; s/N/\\N/g'  |

# Reemplaza ';N' con ';\\N' para representar valores nulos
sed 's/;N/;\\N/g'  |

# Convierte el texto a mayúsculas
sed 's/.*/\U&/'  |

# Reemplaza las barras '/' por guiones '-'
sed 's/\//-/g'  |

# Agrega escape a '\N' al final de la línea
sed 's/,$/;\\N/g'