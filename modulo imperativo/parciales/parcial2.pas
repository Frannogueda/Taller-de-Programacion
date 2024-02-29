{Se lee información acerca de las ventas de productos realizadas en las sucursales de
una empresa. De cada venta se conoce fecha, código de producto, cantidad vendida y monto total de la
venta. La lectura finaliza cuando se lee el código de producto -1, el cual no se procesa. Implementar un
programa para que a partir de la información leída, resuelva los siguientes ítems:

a) Generar un árbol binario de búsqueda ordenado por código de producto, donde cada
nodo contenga el código del producto y la cantidad total vendida. El código de producto no
puede repetirse en el árbol.

b) Realizar un módulo que reciba el árbol generado en a. y una cantidad, y retorne la
cantidad de códigos de producto cuya cantidad total vendida superan la cantidad recibida.
Nota: La información se lee en forma desordenada. Puede existir mas de una venta para
un mismo código de producto.}
program parcial;
	type 
		venta=record
			fecha:integer;
			cantV:integer;
			MontoT:real;
		end;
		lista=^nodoL;
		nodoL=record
			dato:venta;
			sig:lista;
		end;
		arbol=^nodo;
		nodo=record
			Codigo:integer;
			pri:lista;
			HD:arbol;
			HI:arbol;
		end;
	procedure cargarDatos(var a:arbol);
		procedure leerVenta(var v:venta);
			begin
				readln(v.fecha);
				readln(v.cantV);
				readln(v.MontoT);
			end;
		procedure cargarAlArbol(var a:arbol; cod:integer; v:venta);
			procedure crearNodo(var l:lista; v:venta);
				var
					aux:lista;
				begin
					new(aux);
					aux^.dato:=v;
					aux^.sig:=l;
					l:=aux;
				end;
			begin
				if(a=nil)then begin
					new(a);
					a^.codigo:=cod;
					a^.pri:=nil;
					crearNodo(a^.pri,v);
					a^.HD:=nil;
					a^.HI:=nil;
				end
					else
						if(a^.codigo=cod)then
							crearNodo(a^.pri,v)
						else
							if(cod>a^.codigo)then
								cargarAlArbol(a^.HD,cod,v)
								else
									cargarAlArbol(a^.HI,cod,v)
			end;
		var
			v:venta; cod:integer;
		begin
			a:=nil;
			readln(cod);
			leerVenta(v);
			while(cod<>-1)do begin
				cargarAlArbol(a,cod,v);
				readln(cod);
				leerVenta(v);
			end;
		end;
	function ContarCodigos(a:arbol; x:integer):integer;
		function contador(l:lista; x:integer):integer;
			var
				cant:integer;
			begin
				cant:=0;
				while(l<>nil)do begin
					if(l^.dato.cantV>x)then
						cant:=cant+1;
					l:=l^.sig;
				end;
				contador:=cant;
			end;
		begin
			if(a<>nil)then 
				ContarCodigos:=contador(a^.pri,x)+ContarCodigos(a^.HD,x)+ContarCodigos(a^.HI,x)
		end;
	var
		a:arbol; cantVB:integer;
	begin
		cargarDatos(a);{Inciso A}
		readln(cantVB);{Inciso B}
		writeln('la cantidad de codigos que superan a la ingresa son de: ',ContarCodigos(a,cantVB));
	end.
		
		
