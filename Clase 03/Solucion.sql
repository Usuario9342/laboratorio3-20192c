Use Club
--Listar el socio con el legajo 1000.
Select * From Socios where Legajo = 1000

--Listar los socios con los legajos 2000, 6000 y 3000.
Select * From Socios Where Legajo In (2000, 3000, 6000)
Select * from Socios Where Legajo = 2000 or Legajo = 3000 or Legajo = 6000

--Listar todos los socios que posean legajos entre en el 2000 y 6000 (ambos inclusive).
Select * From Socios Where Legajo Between 2000 and 6000
Select * From Socios Where Legajo >= 2000 and Legajo <= 6000

--Listar todos los socios que no posean los legajos 2000, 6000, y 3000.
Select * from Socios where Legajo not in (2000, 3000, 6000)
Select * From Socios Where Legajo <> 2000 and Legajo <> 3000 and Legajo <> 6000

--Listar todos los socios que no posean los legajos entre el 2000 y 6000 (ambos inclusive).
Select * From Socios Where Legajo not between 2000 and 6000
Select * from Socios Where Not (Legajo >= 2000 and Legajo <= 6000)
Select * From Socios Where Legajo < 2000 or Legajo > 6000

--Listar todos las socios de sexo femenino.
Select * From Socios Where Genero = 'F'

--Listar todos los socios que hayan nacido en el a�o 2000.
Select * From Socios Where Year(FechaNacimiento) = 2000

--Listar todos los socios que hayan nacido luego del 01/04/1986.
Select * From Socios Where FechaNacimiento > '01/04/1986'

--Listar el n�mero de legajo, apellido y nombres y g�nero de todos los socios ordenados ascendentemente por apellido.
Select Legajo, Apellidos, Nombres, Genero From Socios Order By Apellidos Asc

--Listar el apellido y nombres y fecha de nacimiento de todos los socios ordenados descendentemente por fecha de nacimiento.
Select Apellidos, Nombres, FechaNacimiento From Socios Order By FechaNacimiento Desc

--Listar todos los socios cuyo nombre comience con vocal.
Select * From Socios Where Nombres Like '[AEIOU]%'

--Listar todos los socios cuyo apellido empiece y termine con consonante.
Select * From Socios Where Apellidos Like '[^AEIOU]%[^AEIOU]'

--Listar todos los socios cuyo apellido tenga seis caracteres y finalice con la A.
Select * From Socios Where Apellidos Like '_____A'

--Listar el legajo, apellido, nombres y edad de cada socio.
Select Legajo, Apellidos, Nombres, Floor(Datediff(Day, FechaNacimiento, getdate())/365.25) As Edad
From Socios

--Listar todas las actividades que se realizan en la Sede 1.
Select * From Actividades Where IdSede = 1

--Listar la actividad menos costosa.
Select Top 1 * From Actividades Order by Costo asc

--Listar la actividad m�s costosa. Listar todas las que cumplan dicha condici�n.
Select Top 1 with ties * From Actividades Order by Costo desc

--Listar el ID, Nombre y Costo de todas las actividades cuyo costo supere los $500 y requieran apto m�dico.
Select ID, Nombre, Costo From Actividades Where Costo > 500 and AptoMedico = 1

--Listar el ID, Nombre y Costo de todas las actividades que se dicten en la Sede 2 y requieran apto m�dico o se dicten en la Sede 4 y superen los $1000.
Select ID,Nombre, Costo From Actividades Where (IDSede = 2 And AptoMedico = 1) or (IDsede = 4 and Costo > 1000)

--Listar todas las sedes que posean tel�fono.
Select * from Sedes Where Telefono Is not null

--Listar los domicilios de todas las sedes que no posean mail.
Select Direccion From Sedes Where Mail is null

--Listar el nombre, domicilio, c�digo postal y la informaci�n de contacto de cada sede. La informaci�n de contacto es el n�mero de tel�fono en primer lugar y la direcci�n de correo electr�nico en caso de no poseer tel�fono.
Select Nombre, Direccion , IDLocalidad, Coalesce(Telefono, Mail) As Contacto From Sedes

--Listar los c�digos postales de todas las sedes (sin repeticiones).
Select distinct idlocalidad from Sedes

--Listar el legajo, n�mero de actividad y como Estado la palabra 'Becado' si el socio se encuentra becado, de lo contrario listar null en el Estado del socio.
Select Legajo, IDActividad, Case When Becado = 1 Then 'Becado' Else null end as Estado
From Inscripciones