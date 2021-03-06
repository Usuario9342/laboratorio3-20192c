---- PARTE 2
--1) - Por cada vecino, listar el apellido y nombre y la 
--cantidad total de propiedades de distinto tipo que posea. (10 puntos)
Select V.Apellidos, V.Nombres, Count(Distinct P.IDTipo) As Cant From Propiedades AS P
Inner Join Vecinos as V ON V.DNI = P.DNI
Group By V.Apellidos, V.Nombres
Order by V.Apellidos asc


--2) - Listar todos los datos de los vecinos que no tengan 
--Casas de más de 80m2 de superficie construida. (20 puntos)
--NOTA: Tipo de propiedad = 'Casa'
Select * From Vecinos Where DNI Not In (
	Select Distinct P.DNI From Propiedades AS P 
	Inner Join Tipos_Propiedades AS TP
	ON P.IDTipo = TP.ID
	Where TP.Tipo = 'Casa' And P.Superficie_construida >= 80
)

--3) - Listar por cada vecino el apellido y nombres, la 
--cantidad de propiedades sin superficie construida y la 
--cantidad de propiedades con superficie construida que posee. 
--(25 puntos)
Select V.Apellidos, V.Nombres,
(Select count(*) From Propiedades Where Superficie_construida = 0
And DNI = V.DNI) AS SinSup, 
(Select count(*) From Propiedades Where Superficie_construida > 0
And DNI = V.DNI) AS ConSup
From Vecinos As V

-- Forma alternativa
Select Aux.Apellidos, Aux.Nombres, Isnull(SUM(Aux.Con), 0) As Con,
Isnull( Sum(Aux.Sin),0) as Sin
From (
Select V.Apellidos, V.Nombres,
Case When Superficie_construida > 0
 Then 1 End As Con,
Case When Superficie_Construida = 0
 Then 1 End as Sin
From Vecinos As V left join
Propiedades as P ON V.DNI = P.DNI
) As Aux
Group By Aux.Apellidos, Aux.Nombres

--4) - Listar por cada tipo de propiedad el tipo y valor promedio.
-- Sólo listar aquellos registros cuyo valor promedio supere los 
-- $900000. (15 puntos)
Select TP.Tipo, AVG(P.Valor) as Promedio
From Tipos_Propiedades as TP
Inner Join Propiedades as P ON TP.ID = P.IDTipo
Group By TP.Tipo
Having AVG(P.Valor) > 900000

--5) - Por cada vecino, listar apellido y nombres y el total 
--acumulado en concepto de propiedades. Si un vecino no posee 
--propiedades deberá figurar acumulando 0. (15 puntos)

Select V.Apellidos, V.Nombres, IsNull(SUM(P.Valor),0) As Suma
From Vecinos as V Left Join Propiedades as P
ON P.DNI = V.DNI
Group by V.Apellidos, V.Nombres

-- Alternativa
Select V.Apellidos, V.Nombres,
(
 Select IsNull(Sum(P.Valor),0) From 
 Propiedades AS P Where
 DNI = V.DNI
) As Suma
From Vecinos as V