

.. _Apéndice D_Optimización del diseño:

==============================
Apéndice D: Optimización del diseño
==============================

Descripción general: diferentes tipos de diseños
************************************

Si está pensando en crear su propio experimento, tiene tres tipos principales de diseños basados en tareas para elegir: diseños de bloques, diseños relacionados con eventos o una mezcla de ambos diseños, a menudo denominados diseños mixtos. Los diseños relacionados con eventos pueden subdividirse en diseños rápidos o lentos relacionados con eventos, dependiendo de la cantidad de jitter en el experimento o de cuánto tiempo haya entre ensayos consecutivos. Estos tres diseños han sido los principales utilizados por los investigadores desde el comienzo de la fMRI basada en tareas, y aunque hay excepciones para ciertos experimentos (por ejemplo, usar un diseño disperso para detener brevemente el escaneo mientras el sujeto escucha un estímulo auditivo, antes de que el escáner comience a medir la señal BOLD de nuevo), estos también pueden verse como variantes de los tres diseños, como verá.

El primer experimento basado en tareas fue un diseño de bloques utilizado en el artículo de Kwong et al. de 1992: El participante en el escáner observaba un patrón de tablero de ajedrez parpadeante durante treinta segundos, seguido de treinta segundos sin tablero de ajedrez, y este patrón intermitente se repetía durante todo el experimento. En otras palabras, este diseño tenía dos condiciones: Tablero de ajedrez y Sin tablero de ajedrez, cada una con una duración relativamente larga. Lo llamamos diseño de bloques porque muchas instancias de la misma condición ocurren en un lapso de tiempo determinado, que suele durar al menos doce segundos, y este período, al mostrarse en una línea que representa la evolución temporal del experimento, tiende a parecerse a un bloque, también llamado vagón de carga. El intervalo entre bloques suele ser lo suficientemente largo como para permitir que la señal BOLD se resuelva a la línea base, lo que puede tardar entre 12 y 20 segundos. Además, modelamos el bloque completo como una instancia única de esa condición, en lugar de modelar todos los ensayos dentro de ese bloque individualmente. La idea es que todos los ensayos produzcan el mismo patrón básico de actividad BOLD y que al agruparlos, la señal se mejorará y el ruido tenderá a cancelarse.

.. figura:: ApéndiceD_Kwong_BlockDesign.png

    Figura de Kwong et al., 1992. Cada rectángulo de "apagado" y "encendido" abarca sesenta segundos de esa condición, en los que el participante vio una pantalla en blanco o un tablero de ajedrez parpadeante. Durante el bloque de "encendido", observe cómo la intensidad de la señal BOLD tiende a aumentar y luego se estabiliza después de aproximadamente doce segundos.

Si la condición que modelamos es fácil de comprender para el participante y genera una señal BOLD robusta, un diseño de bloques puede generar la mayor potencia estadística, ya que presenta la relación señal-ruido más alta de todos los diseños posibles. Sin embargo, como investigador, también debe considerar los efectos psicológicos. Si bien en teoría los diseños de bloques deberían ofrecer la mayor potencia estadística, también pueden resultar aburridos para el participante debido a la naturaleza repetitiva y predecible de ensayos idénticos o similares que se repiten durante largos períodos. Esto puede generar factores de confusión como la habituación o los efectos de predicción, y las respuestas conductuales del participante también pueden volverse uniformes, algo que posiblemente no desee.

Por el contrario, los diseños relacionados con eventos colocan ensayos individuales de diferentes condiciones uno junto al otro con un intervalo de tiempo menor entre ellos. El orden puede determinarse con antelación como parte de la configuración experimental o puede ser aleatorio. Los diseños lentos relacionados con eventos suelen tener al menos 12-15 segundos entre ensayos consecutivos, tiempo suficiente para que la respuesta BOLD vuelva a la línea base antes de que el siguiente estímulo genere otra señal BOLD. Los diseños rápidos relacionados con eventos, por otro lado, tienen menos tiempo entre ensayos consecutivos y, por lo tanto, existe solapamiento en las respuestas BOLD. Ambos tipos de diseños se muestran a continuación, extraídos del sitio web de AFNI:

.. figura:: ApéndiceD_SlowEventRelatedDesign.jpg

  Ejemplo de cronograma para un diseño lento relacionado con eventos. La fila superior muestra la presentación individual de cada prueba (cada una con un código de color que representa una condición diferente), mientras que la fila central muestra la respuesta hemodinámica correspondiente a cada tipo de estímulo. La fila inferior ilustra la suma de los HRF de la fila central. Cabe destacar que hay tiempo suficiente entre pruebas para que la respuesta BOLD vuelva a su valor inicial antes de la presentación del estímulo; por lo tanto, la forma de las respuestas BOLD individuales y sumadas son idénticas.

.. figura:: ApéndiceD_RapidEventRelatedDesign.jpg

  Ejemplo de cronograma para un diseño rápido relacionado con eventos; el significado de cada fila es el mismo que en la figura anterior. Cabe destacar que, en este caso, hay menos tiempo entre ensayos consecutivos y una superposición considerable entre sus respuestas en negrita. Por consiguiente, la suma de sus respuestas en negrita (representada en la fila inferior) es una convolución, o media móvil, de las respuestas individuales.

Independientemente de si se utilizan diseños lentos o rápidos relacionados con eventos, la idea de ambos es hacer que el experimento sea más atractivo para el participante, a la vez que se maximiza la cantidad de ensayos individuales presentados y se maximiza la discriminabilidad entre condiciones. Aumentar el número de ensayos es bastante sencillo, pero ¿qué significa maximizar la discriminabilidad entre condiciones? Recuerde que la respuesta BOLD típica tarda en desplegarse y generalmente se asemeja a una distribución gamma, es decir, una curva en forma de campana con una cola larga sesgada a la derecha. Si muchas respuestas BOLD ocurren con la suficiente proximidad temporal como para que una comience antes de que la anterior se resuelva, ambas se promedian a lo largo del tiempo. Este fenómeno, conocido como **convolución**, es parte de la razón por la que la señal BOLD observada suele parecer ruidosa, irregular y aleatoria. Existen otros factores que contribuyen a la confusión general de la señal, pero incluso al eliminar estas otras fuentes de ruido de los datos, se obtiene una señal convolucionada que oculta la amplitud de cada condición individual. Para calcular con precisión la amplitud de cada condición, necesitamos deconvolucionar la señal; en otras palabras, necesitamos desenredar el nudo de respuestas BOLD que se superponen entre sí.

En principio, la deconvolución es fácil de entender, y todos los paquetes de análisis fMRI contienen algoritmos que la realizan automáticamente. La clave está en que el solapamiento no debe ser demasiado regular; es decir, el intervalo entre un estímulo y el siguiente no puede ser el mismo ni cercano al mismo en todo momento. Dicha regularidad genera colinealidad, lo que significa que dos regresores están altamente correlacionados. El término colinealidad se utiliza en estadística para describir la predicción de un regresor mediante una combinación lineal de otros regresores; si esto ocurre, el número de soluciones posibles puede llegar a ser casi infinito, lo que imposibilita la estimación de los pesos beta de los regresores individuales. Esto se ilustra en la siguiente figura, también extraída del sitio web de AFNI:

.. figura:: ApéndiceD_Colinealidad.png

  Ejemplo de colinealidad. Si estas tres condiciones (resaltadas en verde, rojo y azul) ocurren siempre al mismo tiempo, resulta imposible determinar la contribución de cada condición a la señal convolucional general, representada aquí en magenta y fijada en un único valor. Se necesitan intervalos entre ensayos aleatorios, o jitter, para desenredar con precisión la señal convolucional en sus componentes.

.. nota::

  Para comprender esto de forma más intuitiva, imagina que estás en una fiesta ruidosa donde hablas con dos personas. Si una persona habla, hace una pausa y luego la otra habla, probablemente podrás entenderlas a todas, a pesar del ruido de fondo. Si, en cambio, hablan a la vez, será difícil entender lo que dicen; y si repiten lo que acaban de decir y una persona empieza a hablar segundos después de que la otra, probablemente entenderías la parte de la conversación que no se solapa con la de la otra. Sin embargo, si repiten sus frases con la misma frecuencia, nunca podrás descifrar completamente lo que dicen. Pero si repiten sus frases, solo que con solapamiento en diferentes momentos, eventualmente podrás entender lo que dicen al unir las partes individuales. De igual manera, al variar el grado de solapamiento de las respuestas BOLD, con el tiempo podemos reconstruir una imagen más clara de cómo se ven individualmente.

Quizás se pregunte si existe una cantidad óptima de fluctuación que se pueda aplicar a cada experimento, dada la duración del análisis y el número de ensayos. De hecho, existen paquetes de software diseñados para crear una programación de tiempos que optimiza la potencia de su diseño, es decir, la capacidad de detectar un efecto si existe. Sin embargo, antes de continuar, deberá comprender la diferencia entre **detección** y **estimación**. Los investigadores suelen estar más interesados en la detección, o la capacidad de 1) encontrar un efecto y 2) determinar si la amplitud de la respuesta BOLD es significativa para una condición en comparación con la línea base, o si la respuesta BOLD para una condición es significativamente diferente de otra. Los diseños de bloques son excelentes para la detección, porque la respuesta BOLD para una condición está aislada de las demás; si realmente existe un efecto, este diseño experimental le brinda la mayor potencia para detectarlo y también proporciona la mayor relación señal-ruido. De manera similar, en un diseño relacionado con eventos, esto significa optimizar el intervalo de tiempo entre ensayos consecutivos para discriminar mejor la respuesta BOLD entre condiciones y estimar con precisión la magnitud de la respuesta de cada condición.

La estimación, por otro lado, es la medición precisa de puntos de tiempo individuales a lo largo de la respuesta BOLD. Esto se relaciona con otro tipo de análisis llamado análisis de respuesta de impulso finito (FIR), en el que los puntos de tiempo se pueden comparar entre sí y la magnitud de la respuesta BOLD se prueba para detectar diferencias significativas. El usuario especifica el número de puntos de tiempo a estimar y el tiempo en el que se estiman. Por ejemplo, se puede querer estimar diez puntos de tiempo dentro de una ventana de dieciocho segundos, o uno cada dos segundos (incluyendo una estimación del punto de tiempo cero, que indica el inicio de la prueba). Los diseños relacionados con eventos son mucho más adecuados para la estimación, ya que la fluctuación de las pruebas permite estimar diferentes puntos de tiempo a lo largo de la curva de la respuesta BOLD; los diseños de bloques, por el contrario, tienen demasiada superposición del mismo tipo de prueba, lo que dificulta, si no imposibilita, la medición de los detalles más finos de la respuesta BOLD de esa condición.

.. figura:: ApéndiceD_DesignTradeoffs.png

  Ilustración de las compensaciones entre detección y estimación. Los diseños de bloques proporcionan la mejor detección, a la vez que minimizan la estimación; un diseño con intervalos entre ensayos completamente aleatorizados ofrece la mejor estimación, pero la menor potencia de detección. Los diseños semialeatorios, que otorgan mayor importancia a los intervalos entre ensayos más cortos que a los más largos (es decir, hacen que la ocurrencia de intervalos más cortos sea relativamente más frecuente), proporcionan un equilibrio entre detección y estimación. Los diseños periódicos, similares a los diseños lentos relacionados con eventos, producen una estimación deficiente y una potencia baja.

.. nota::

  Para analizar esto desde una perspectiva diferente y comprender la compensación entre optimizar la fluctuación y optimizar la potencia, tanto para la detección como para la estimación, considere un diseño experimental en el que solo se presenta una instancia de un ensayo y se permite suficiente tiempo para que la respuesta BOLD vuelva a la línea base antes de la presentación del segundo ensayo (por ejemplo, veinte segundos). Esto permitiría una buena estimación y detección, suponiendo que se tuviera tiempo para suficientes ensayos para obtener una buena relación señal-ruido. Sin embargo, probablemente se encontrará con limitaciones en cuanto al tiempo de escaneo, dependiendo de su presupuesto, y los participantes no suelen querer estar en el escáner más de sesenta a noventa minutos. Además, debe considerar cómo se siente esto psicológicamente: un ensayo cada veinte segundos probablemente aburrirá al sujeto, y probablemente se encontrará con confusiones relacionadas con la atención y la fatiga.

En resumen, el mejor diseño experimental depende no solo de optimizar el jitter, sino también de equilibrarlo con la mayor cantidad de ensayos que se puedan obtener razonablemente en un tiempo determinado, y también de considerar cómo se siente el experimento psicológicamente. Por ejemplo, si tuviéramos un experimento que aprovechara el control cognitivo medido con ensayos congruentes e incongruentes, debería tener en cuenta un fenómeno llamado efecto Gratton. Este es un fenómeno en el que la señal BOLD es mayor para los ensayos incongruentes inmediatamente posteriores a los ensayos congruentes que para los ensayos congruentes posteriores a los ensayos congruentes, o para los ensayos congruentes posteriores a los ensayos incongruentes, lo que puede reflejar una medida de la preparación del cerebro para procesar un ensayo incongruente próximo. Si genera un esquema de temporización utilizando optseq2 u OptimizeX (dos paquetes de software populares para crear temporizaciones para diseños experimentales), puede terminar con un diseño que tenga una gran cantidad de ensayos incongruentes que preceden a los ensayos congruentes, lo cual puede ser deseable o no. En cualquier caso, debe examinar el esquema de cronometraje, probarlo y asegurarse de que los participantes puedan desempeñarse como espera. Ahora examinaremos cada uno de estos paquetes de optimización de diseño.

Optimización del diseño con optseq2
********************************

`Optseq2`__ fue desarrollado por Doug Greve del Hospital General de Massachusetts. Es un paquete fácil de usar que requiere una terminal Unix o un emulador de terminal. Sin embargo, tenga en cuenta que optseq no parece recibir mantenimiento activo y que está diseñado para optimizar la estimación de su diseño; en otras palabras, mejorará la capacidad de su experimento para estimar puntos a lo largo de la respuesta BOLD, a expensas de la detección.

He escrito un tutorial para optseq2 que se puede encontrar aquí`__, junto con vídeos que demuestran cómo usarlo.

Optimización del diseño con OptimizeX
**********************************

.. nota::

  La mayor parte del texto y las figuras de esta sección y la siguiente se han extraído del curso anual de formación en fMRI de la Universidad de Michigan.

Otra herramienta de optimización es `OptimizeX
    `__, desarrollado por Bob Spunt. Este es un paquete de Matlab que genera cronogramas de tiempo para maximizar la detección de la respuesta BOLD. Permite indicar qué contraste se desea optimizar de entre todas las combinaciones posibles de la matriz de diseño.

This package will also help you to maximize your design **efficiency**, which can be thought of as the inverse of variance. If we have a timing scheme that optimizes the sampling along different curves of the BOLD response, we will reduce our uncertainty of the shape of the individual BOLD response for each condition, and therefore increase our power to detect an effect that is actually there. In other words, efficiency is a measure of how well the timing scheme allows SPM to deconvolve the amplitudes of the individual conditions, and, all things being equal, a higher efficiency is more desirable. Best of all, efficiency can be calculated before you begin scanning, which can save you time and money from having to later edit your design.

.. figure:: AppendixD_Efficiency.png

    Illustration of the difference in power yield for the most efficient and least efficient timing schedule for a given experiment, focusing on a sample size of N=30 subjects. Note that this assumes everything else is equal - number of conditions and number of trials - all that changes is the timing between the trials. Figure courtesy of Jeanette Mumford.

To get started, click on the link above and then click on ``Download ZIP`` from the menu bar on the left. When it has finished downloading, unzip the package, and then (assuming that it is in your Downloads directory), move it to your home directory and add it to your Matlab path:

::

  mkdir '~/OptimizeX/Demo'
  movefile('~/Downloads/spunt-easy-optimize-x-7c4d2f8/*', '~/OptimizeX')
  addpath '~/OptimizeX'
  cd ~/OptimizeX/Demo


This will create the folders ``OptimizeX`` and the subfolder ``DemoFiles`` in your home directory; the scripts to run OptimizeX will be placed in the ``OptimizeX`` folder, and we have the subdirectory into which we can write out our example timing schedules.

If you then type

::

    optimizeXGUI

You should now see the main input dialogue:

.. figure:: AppendixD_OptimizeX_GUI.png

The menu has the following options:

::

  General Settings
  
  TR (s): TR you will use to acquire images
  High-Pass Filter Cutoff (s): high-pass filter you will use to analyze images
  Task Settings
  
  N Conditions: number of conditions in your design
  N Trials Per Condition: number of trials per condition (unbalanced OK, e.g., 25 20 15 25)
  Maximum Block Size: block = trials from same condition occurring in a row
  Timing (s)
  
  Time Duration: duration of your trials (0 purely event-related)
  Mean ISI: mean interstimulus interval
  Min ISI: minimum value for interstimulus interval
  Max ISI: maximum value for interstimulus interval
  Time before first trial: "rest" interval to add to beginning of scan
  Time after last trial: "rest" interval to add at end of scan
  Optimization Settings
  
  N Designs to Save: number of "optimal" designs to save
  N Generations to Run: number of generations to test
  N Designs Per Generation: number of designs to include in each generation
  Max Time to Run (minutes): maximum amount of time to run the program


Feel free to create your own unique design by modifying the inputs. Or, you can just use the "default" values to proceed on to the next step, which is to tell the software which contrasts you care most about:

.. figure:: AppendixD_Settings.png

This is me telling the software that I am looking for a design that maximizes the efficiency of two contrasts among my conditions

.. figure:: AppendixD_ContrastSpecification.png

This indicates that although I do care about the comparison among predictors 1 and 3 (Contrast 1), I actually care more about the comparison of predictors 2 and 4 (Contrast 2).

That's it! The software will do the rest of the work, some of which you can see in the MATLAB command window:

.. figure:: AppendixD_MatlabOutput.png

Note that the efficiency values have no unit and that larger values indicate more efficient designs.

Once it finishes, you should see a figure pop up showing you the most efficient design matrix:

.. figure:: AppendixD_DesignMatrix.png

In addition, you should see a new folder starting with 'best_designs_' followed by the current date in the directory in which you ran the program (which should be ``~/OptimizeX/Demo``. Inside that directory are .csv files and their corresponding .txt files for each of the of the number of designs that you set to write out in the OptimizeX menu (under 'N Designs to Save'). You can load the .csv files into Matlab or Excel, which would look like this:

.. figure:: AppendixD_TimingSchedule.png

You can read in the .txt files in Matlab and display their contents with:
::

    load('design1.txt');
    design1

Alternatively, OptimizeX also writes out the file designinfo.mat, which includes a structure with all the designs that you requested OptimzeX to save. You can read it into Matlab with:
::

    load('designinfo.mat');

...and access for example the first design in the structure using:

::

    design{1}.combined

For most applications, this should be all of the information you need to implement your experiment, and to do so in a manner that is optimal given the contrasts you care about. Of course, you might want to think about running the software for more than a minute if you do decide to use this for a study! There is no hard-and-fast rule for how long you do need to run it, but it wouldn't hurt (presumably) to run it overnight.


Evaluating Design Efficiency
****************************

In the previous two sections, you got a feel for design optimization. In this last section, we'll learn to more concretely assess design efficiency. This will allow you to evaluate and compare designs, and better understand how to optimize them.

Let's begin by evaluating the optimized design that you just created. Within the OptimizeX folder, your design should have been saved in a directory called "best_designs_DATE_TIME." Locate that directory, which should be under ``~/OptimizeX/Demo``, and load the file "designinfo.mat".

load designinfo % make sure you are in the right directory
This will load a variable called "design" into your workspace that contains the design information for each of the designs you generated. In particular, the design matrix is stored in a field called "X":

::

    X = design{1}.X; % store the first design matrix into variable X
    figure
    imagesc(X)
    colormap('gray');

This command will plot the design matrix you observed before, but without the intercept (the last column that was on the right).

Now, let's evaluate the design. First, we'll examine the variance inflation factors (VIF). Variation inflation factors estimate how stable/unstable parameter estimates will be. You get one variance inflation factor per regressor. A variance inflation factor of 1 is perfect and indicates that the design will provide a stable estimate of the parameter. A variance inflation factor of 2 indicates that there will be a twofold increase in the variance of the parameter. In other words, if you were to repeat the experiment over and over assuming the same underlying true parameter, the estimate of that parameter would be variable to a factor of 2. Similarly, a variance inflation factor of 3 indicates a threefold increase, and so on. There is no hard rule on how much variance inflation one can tolerate, but the lower the better!

::

    vif = diag(inv(corrcoef(X)))';
    vif

Are the VIFs near 1? Are they high (e.g. > 10)? VIFs are inflated due to multi-collinearity. Let's take a look at the correlation between regressors:

::

    r = corrcoef(X);
    r

This shows the correlation matrix. Are there strong correlations between any regressors? How might you decrease the correlation between regressors?

Next, we will look at the efficiency of the design. While variance of parameter estimates (VIFs) are bad, variance of the regressors used to estimate those parameters is good. This is because variance in a regressor gives it a unique signature that can be observed in the signal (if it is there).

More technically, efficient designs minimize the quantity (X'X)-1. Or in MATLAB inv(X'*X). In particular, we are interested in the diagonal elements of this matrix, each of which corresponds to a predictor in our design. So, we'll calculate this quantity and focus on the diagonals. Since we typically think of efficiency in positive terms (i.e. more efficiency is better), we'll take the reciprocal:

::

    eff = (1./diag(inv(X'*X)))';
    eff

Note that this is a unit-less measure. It is affected by the scaling of the design matrix (and scaling of contrasts when we calculate contrast efficiency). As a result, it is a relative term and comparing grossly different designs is not meaningful. But, so long as we keep our scaling constant, we can compare different simulations of a design (e.g., same number of conditions and trials) using this metric.

While higher efficiency for each regressor is a good thing, what we are typically interested in are contrasts. When you ran the optimizeX script previously, you gave it the contrasts that you wanted to be optimized. Let's see the metric it used to measure this. The contrasts you gave the script were saved in the variable "params.L."

::

    C = params.L'; % extract the contrasts and transpose for matrix multiplication
    effCons = (1./diag(C'*inv(X'*X)*C))';
    effCons

Again, this is unit-less and should be used for relative comparisons. If you told the script to weight one contrast more than another, you might see that the more highly weighted contrast has greater efficiency. If you asked for equal weighting, then both contrast efficiencies should be about equivalent.

Next, re-run the Optimization script, but this time, increase the ISI. How does this change affect the VIFs? The efficiency?

Finally, you may be interested in evaluating designs you have used in the past. Locate the SPM.mat file of the design that you have estimated, which contains the design matrix, which you can access with the following code:

::

    load SPM % make sure you are in the right directory
    X = SPM.xX.X(:,SPM.Sess(1).col); % pick out Session/Run 1
    
    % Now let's get the contrast from our SPM file
    xCon=horzcat(SPM.xCon(:).c)';
    xCon=xCon(:,1:3);

This code extracts the regressors for the first session/run. If you had a multi-session/run design, you could change the column indexing to access different sessions/runs, or all of them. Now, you can repeat the steps above to examine the VIFs and efficiencies. Are there any VIFs that are particularly bad? Are there any regressors that are relatively inefficient? If so, what elements of the design do those correspond to? Will this be problematic for the design estimation? These are questions you will need to ask yourself as you decide on the best design to use.

Video
*****

You can see how to do this on your computer by watching `this video 
    `__.


Summary
*******

You now have the tools and concepts to optimize your design: First, by increasing the efficiency of your design matrix using OptimizeX, and also by thinking about any potential confounds that might arise with a given design. Remember that the most efficient design doesn't necessarily mean the best one; you will have to decide for yourself whether a given timing schedule "feels" right, and for this there is no substitute for experience.

    
   

