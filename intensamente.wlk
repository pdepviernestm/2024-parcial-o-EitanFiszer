class Persona {
  const edad

  const emociones = []

  // 1
  method esAdolecente() = edad.between(12, 19)

  // 2
  method agregarEmocion(emocion) = emociones.add(emocion)

  //3
  method puedeExplotar() = emociones.all({e => e.puedeLiberarse()})

  //4  
method hacerEvento(evento) {
    emociones.forEach({ e => e.liberar(evento) })
}}

//6
class Grupo{
    const integrantes=[]
    method vivirEvento(evento)= integrantes.forEach{p=>p.hacerEvento(evento)}
}
class Emocion {

    var property intensidad=500
    var property cantidadEventos = 0
    var property criterioIntensidad = 5 

  // Método para determinar si una emoción puede liberarse
  method puedeLiberarse() = true

    //5
    method cambiarCriterioIntensidad(nuevoCriterio) {
        criterioIntensidad = nuevoCriterio
    }

    method intensidad()=intensidad

  method liberar(evento) {
    cantidadEventos += 1
    if(self.puedeLiberarse()){
        intensidad -= evento.impacto()
    }
  }

    method intensidadElevada() = intensidad>criterioIntensidad
}

class Furia inherits Emocion(){
    const palabrotas=[]

    override method puedeLiberarse() = self.tienePalabrota7() and self.intensidadElevada()
    method tienePalabrota7() = palabrotas.any{p=>p.size()>7}

}

class Alegria inherits Emocion{

    override method initialize() {
        intensidad = intensidad.abs()
        }
    override method puedeLiberarse() = self.intensidadElevada() && self.eventosPar()
    method eventosPar() = cantidadEventos%2 == 0

    }

class Tristeza inherits Emocion{
    var property causa = "melancolia"
    override method puedeLiberarse() = causa != "melancolia" && self.intensidadElevada()
    override method liberar(evento){
        super(evento)
        causa = evento.descripcion()
    }
}

class DesagradoYtemor inherits Emocion{
    override method puedeLiberarse() = cantidadEventos > intensidad && self.intensidadElevada()
}

//Se libera si el impacto de la última emocion fue mayor al criterio de intensidad
class Especial inherits Emocion{
    var property recuerdo = 10
    method intesidad() = 100
    override method puedeLiberarse() =  recuerdo > criterioIntensidad
    override method liberar(evento){
        super(evento)
        recuerdo = evento.impacto()
    }
}

class Evento{
    const property impacto
    const descripcion

    method descripcion() = descripcion 
}

const tristeza = new Alegria(intensidad=-100)
const evento1 = new Evento(impacto=2,descripcion="")