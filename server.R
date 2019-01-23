library(shiny)
library(shinyjs)

source('init.R')

shinyServer(function(input, output, session)
    observeEvent(input$okCorreo,
    {
        email <- input$correo
        idx <- match(email, profesores$correo)
        if (is.na(idx))
        {
            alert("El correo electrónico indicado no está registrado en el sistema. Revisa que lo has escrito correctamente. Si te has incorporado recientemente a la ETSIDI, por favor, ponte en contacto con el director de tu departamento para que solicite la inclusión de tu correo en la aplicación de docencia y tutorías.")
            stopApp()
        }
        else
        {
            nombre <- profesores$nombre[idx]
            to <- profesores$correo[idx]
            mensaje <- generaMensaje(nombre, cuerpo)
            correo <- sendMail(to, subject, mensaje,
                               send = TRUE)
            alert("Se ha enviado un mensaje al correo electrónico indicado.")
            stopApp()
        }
    })
    )
