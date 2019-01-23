library(shiny)
library(shinyjs)

source('init.R')


## Cabecera con logos
header <- fluidRow(
    column(4, align = 'center', img(src = logoUPM, width = 72)),
    column(4, align = 'center',
           h2("Recordatorio de Enlace para Tutorías y Horario Docente del Profesorado"),
           h5("Subdirección de Ordenación Académica")),
    column(4, align = 'center', img(src = logoETSIDI, width = 72))
)

## UI de profesor
correoUI <- wellPanel(
    fluidRow(
        column(4,
               textInput('correo', label = 'Correo eléctronico UPM:')
               ),
        column(8,
               h3(""),
               p('Indica tu correo electrónico UPM.'),
               p('Recibirás un mensaje con el enlace que te corresponde y con un recordatorio de las instrucciones.')
               )
    ),
    fluidRow(
        column(2,
               actionButton("okCorreo",
                            "Confirmar",
                            icon = icon("check"))
               ))
)

## UI completa
shinyUI(
    fluidPage(
        useShinyjs(),
        includeCSS("styles.css"),
        header,
        correoUI
    )
)
