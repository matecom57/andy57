

.. _SPM_04_Estadísticas_Generales_Modelo_Lineal:

===================================
Capítulo 4: El modelo lineal general
===================================

.. nota::

  Este capítulo es una breve introducción al Modelo Lineal General (MLG) y su aplicación a los datos de fMRI. Para una introducción más completa al MLG, consulte este tutorial.`__ de StatSoft.

---------
 
Introducción
*********


Ahora llegamos al **Modelo Lineal General**, o MLG. Con un MLG, podemos usar uno o más **regresores**, o variables independientes, para ajustar un modelo a una medida de resultado, o **variable dependiente**. Para ello, calculamos valores llamados **pesos beta**, que son los pesos relativos asignados a cada regresor para un mejor ajuste a los datos. Cualquier discrepancia entre el modelo y los datos se denomina **residuos**.

Los símbolos que representan cada uno de estos términos se muestran en la siguiente ecuación, que puede acortarse o ampliarse dependiendo de la cantidad de regresores en su modelo:

.. figura:: 05_04_GLM_Equation.png

Veamos cómo aplicar esto a un ejemplo sencillo. Imaginemos que queremos predecir el promedio de calificaciones (GPA) en función de la estatura, el coeficiente intelectual (CI) y el número de bebidas por semana. Podríamos encontrar que el CI tiene una asociación positiva con el GPA, que el número de bebidas tiene una asociación negativa y que la estatura no tiene ninguna asociación; y asignamos a cada uno de estos regresores pesos beta para que se ajusten mejor a los datos. Por ejemplo, tal vez cada punto adicional de CI se asocie con un aumento adicional de 0,05 en el GPA, mientras que cada bebida adicional por semana se asocie con una disminución de -0,07 en el GPA. En ese caso, nuestro modelo y sus pesos beta se verían así (donde los asteriscos representan pesos beta estadísticamente significativos o que es improbable que estén asociados con la medida de resultado por casualidad):

.. figura:: 05_04_GLM_Example.png


Este GLM puede ampliarse para incluir numerosos regresores, pero, independientemente de su número, el GLM supone que los datos pueden modelarse como una combinación lineal de cada uno de los regresores; de ahí el nombre de Modelo Lineal General. Veremos cómo aplicar el GLM a datos de fMRI en el siguiente capítulo.

   

