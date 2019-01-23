library(openssl)

source('../misc/funciones.R')
source('../misc/defs.R')

old <- setwd('../directorio')
source('leeProfes.R')
setwd(old)
profesores <- do.call(rbind, profesores)
rownames(profesores) <- NULL

## Si es FALSE, envía correo completo. Si es TRUE, sólo recordatorio
recordar <- TRUE 


sendMail <- function(to, subject, cuerpo,
                     send = FALSE)
{
    correoFile <- file.path(tempdir(), "correo.txt")
    writeLines(cuerpo, correoFile)
    if (isTRUE(send))
        subject <- paste0("'", subject, "'")
    system(paste("cat", correoFile,
                 "| mail -s", subject, to))
    invisible(correoFile)
}

generaMensaje <- function(nombre, texto)
{
    firma <- paste0(readLines('firma.txt'), collapse = '\n')
    appURL <- 'http://programas.etsidi.upm.es/SOA/docencia'
    sprintf(texto, 
            paste(appURL, md5(nombre), sep = '?'),
            firma)
}

instrucciones <- readLines('instrucciones.txt', encoding = "UTF-8")
sInstrucciones <- 'Actividad Docente y Tutorías'

recordatorio <- readLines('recordatorio.txt', encoding = "UTF-8")
sRecordatorio <- 'Recordatorio de enlace para actividad docente y tutorías'

cuerpo <- ifelse(isTRUE(recordar), 
       paste0(recordatorio, collapse = '\n'),
       paste0(instrucciones, collapse = '\n'))

subject <- ifelse(isTRUE(recordar),
                  sRecordatorio,
                  sInstrucciones)


