--Listar para cada actividad, todos los datos de la sede donde se realiza la actividad.
Select * From Actividades as A
Inner Join Sedes as S ON A.IDSede = S.ID

--Listar el nombre y el costo de las actividades y la direcci�n, c�digo postal y tel�fono donde se realiza la actividad. (XLS)
Select A.Nombre, A.Costo, S.Direccion, S.IDLocalidad, S.Telefono from Actividades as A
Inner Join Sedes as S ON A.IDSede = S.ID

--Listar el nombre y costo de todas las actividades que se realicen en el C�digo Postal 1111.
Select A.Nombre, A.Costo from Actividades as A
Inner Join Sedes as S ON A.IDSede = S.ID
Where S.IDLocalidad = 1111

--Listar el nombre, direcci�n y nombre de la localidad de todas las sedes. 
--Incluir en el listado aquellas localidades que no tengan una sede asociada completando con NULL los campos de la sede que no pudo asociarse a la localidad. (XLS).
Select S.Nombre, S.Direccion, L.Nombre as Localidad From Sedes as S
Right Join Localidades as L ON S.IDLocalidad = L.ID

--Listar el apellido y nombre y g�nero de los socios que se encuentren becados (XLS).
Select Distinct S.Apellidos, S.Nombres, S.Genero From Socios AS S
Inner Join Inscripciones as I ON I.Legajo = S.Legajo
Where I.Becado = 1

--Listar el nombre de todas las actividades que realiza el socio con Legajo 1000.
Select Distinct A.Nombre From Socios AS S
Inner Join Inscripciones as I ON I.Legajo = S.Legajo
Inner Join Actividades as A ON A.ID = I.IDActividad
Where S.Legajo = 1000

--Listar el nombre de todas las actividades que tengan alg�n inscripto en el a�o 2019 (sin repeticiones).
Select Distinct A.Nombre From Actividades AS A
Inner Join Inscripciones as I ON I.IDActividad = A.ID
Where Year(I.FechaInscripcion) = 2019

--Listar el nombre, apellido, c�digo de inscripci�n y fecha de inscripci�n de las inscripciones que haya realizado un socio. 
--Incluir en el listado a los socios que no poseen inscripciones completando con NULL los campos de la inscripci�n que no pudo asociarse al socio. (XLS)
Select Distinct S.Apellidos, S.Nombres, I.IDInscripcion, I.FechaInscripcion From Socios AS S
Left Join Inscripciones as I ON I.Legajo = S.Legajo

--Listar el nombre y apellido de los socios que no realicen ninguna actividad (que no posean inscripciones) (XLS).
Select Distinct S.Apellidos, S.Nombres From Socios AS S
Left Join Inscripciones as I ON I.Legajo = S.Legajo
Where I.IDInscripcion is null

--Listar el nombre y apellido del socio, nombre de actividad y costo de la actividad de todos los socios de sexo femenino que realicen actividades que requieren apto m�dico. (XLS)
Select Distinct S.Nombres + ' ' + S.Apellidos As Apenom, A.Nombre, A.Costo From Socios AS S
Inner Join Inscripciones as I ON I.Legajo = S.Legajo
Inner Join Actividades as A ON A.ID = I.IDActividad
Where S.Genero = 'F' And A.AptoMedico = 1

--Listar nombre y apellido del socio, nombre de la actividad y nombre de la sede donde la realiza de aquellos socios que se encuentren becados en dicha actividad.
Select S.Apellidos, S.Nombres, A.Nombre, SE.Nombre  From Socios AS S
Inner Join Inscripciones as I ON I.Legajo = S.Legajo
Inner Join Actividades as A ON A.ID = I.IDActividad
Inner Join Sedes as SE ON SE.ID = A.IDSede
Where I.Becado = 1

--Listar el nombre de la actividad y el nombre de la localidad donde se realiza ordenado ascendentemente por el nombre de la actividad.
Select S.Nombre, S.Direccion, L.Nombre as Localidad From Sedes as S
Inner Join Localidades as L ON S.IDLocalidad = L.ID
Order By L.Nombre asc

--Listar el apellido y nombres de todos los socios (sin repeticiones) que realicen alguna actividad en San Fernando o Tigre.
Select Distinct S.Apellidos, S.Nombres From Socios AS S
Inner Join Inscripciones as I ON I.Legajo = S.Legajo
Inner Join Actividades as A ON A.ID = I.IDActividad
Inner Join Sedes as SE ON SE.ID = A.IDSede
Inner Join Localidades as L ON L.ID = SE.IDLocalidad
Where L.Nombre IN ('San Fernando', 'Tigre')

--Listar el socio que haya pagado la cuota m�s cara indicando el apellido y nombre del socio, el per�odo (Mes+A�o) y el importe.
Select Top 1 S.Apellidos, S.Nombres, P.Mes, P.Anio, P.Importe
From Socios as S inner join Pagos AS P ON S.Legajo = P.Legajo
Order by P.Importe Desc

--Listar el nombre de la actividad m�s cara que posea alg�n becado.
Select Top 1  A.Nombre From Actividades AS A
Inner Join Inscripciones as I ON I.IDActividad = A.ID
Where I.Becado = 1
Order by A.Costo Desc

--Listar nombre y apellido del socio, nombre de la actividad y la cantidad de d�as transcurridos desde que se inscribi� a dicha actividad. 3.
--Ordenarlo por cantidad de d�as de manera descendente.
Select Distinct S.Apellidos, S.Nombres, DateDiff(Day, I.FechaInscripcion, getdate()) as DiasTranscurridos From Socios AS S
Inner Join Inscripciones as I ON I.Legajo = S.Legajo
Order by 3 desc