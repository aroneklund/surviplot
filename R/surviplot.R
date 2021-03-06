# surviplot.R
#
# Aron Eklund   eklund@cbs.dtu.dk
#
# formerly known as "survplot.R" until 2016-08-08
#
#


nrisk <- function(x, times = pretty(x$time)) { 
    stopifnot(class(x) == 'survfit')
    if('strata' %in% names(x)) {
      ns <- length(x$strata)
      idx <- rep.int(1:ns, x$strata)
      str.n.risk <- split(x$n.risk, idx)
      str.times <- split(x$time, idx)
      m <- sapply(times, function(y) {
        sapply(1:ns, function(i) {
          w <- which(str.times[[i]] >= y)[1]
          ifelse(is.na(w), 0, str.n.risk[[i]][w])
        })
      })
      rownames(m) <- names(x$strata)
    } else {  # no strata
      m1 <- sapply(times, function(y) {
          w <- which(x$time >= y)[1]
          ifelse(is.na(w), 0, x$n.risk[w])
      })
      m <- matrix(m1, nrow = 1)
    }
    colnames(m) <- times
    m
}


addNrisk <- function(x, at = axTicks(1), 
      line = 4, hadj = 0.5, 
      title = 'Number at risk', title.adj = 0, 
      labels, hoff = 5, col = 1) {
    m <- nrisk(x, times = at)
    ns <- nrow(m)  # number of strata
    if(missing(labels)) {
      if(ns > 1) { 
        labels <- names(x$strata)
      } else {
        labels <- NA
      }
    }    
    label.pad <- paste(rep(' ', hoff), collapse = '') 
    labels2 <- paste(labels, label.pad, sep = '')
    labels2[is.na(labels)] <- NA
    col <- rep(col, length.out = ns)
    hasTitle <- (!is.null(title)) && (!is.na(title))
    if(hasTitle) {
      title(xlab = title, line = line, adj = title.adj)
    }
    for (i in 1:ns) {
      axis(1, at = at, labels = m[i,], 
        line = line + i + hasTitle - 2, tick = FALSE, 
        col.axis = col[i], hadj = hadj)
      axis(1, at = par('usr')[1], labels = labels2[i],
        line = line + i + hasTitle - 2, tick = FALSE,
        col.axis = col[i], hadj = 1)
    }
    invisible(m)
}



surviplot <- function(x, data = NULL, subset = NULL, 
     snames, stitle, 
     col, lty, lwd,
     show.nrisk = TRUE, color.nrisk = TRUE,
     hr.pos = 'topright', legend.pos = 'bottomleft', ...) {
  eval(bquote(s <- survfit(x, data = data, subset = .(substitute(subset)))))
  if('strata' %in% names(s)) {
    if(missing(stitle)) stitle <- strsplit(deparse(x), " ~ ")[[1]][2]
    if(missing(snames)) {
      snames <- names(s$strata)
      prefx <- paste(strsplit(deparse(x), " ~ ")[[1]][2], '=', sep = '')
      if(all(substr(snames, 1, nchar(prefx)) == prefx)) {
        snames <- substr(snames, nchar(prefx) + 1, 100)
      }
    }
    ns <- length(s$strata)
    stopifnot(length(snames) == ns)
  } else {    # no strata
    ns <- 1
    snames <- NA
    legend.pos <- NA
  }
  if(show.nrisk) {
    mar <- par('mar')
    mar[1] <- mar[1] + ns + 0.5
    opar <- par(mar = mar)
    on.exit(par(opar))
  }
  if(missing(col)) col <- 1:ns
  if(missing(lty)) lty <- 1
  if(missing(lwd)) lwd <- par('lwd')
  plot(s, col = col, lty = lty, lwd = lwd, ...)
  if(length(legend.pos) > 1 || !is.na(legend.pos)) {
    legend(legend.pos, legend = snames, title = stitle,
      col = col, lty = lty, lwd = lwd, bty = 'n')
  }
  if(ns == 2) {
    eval(bquote(cox <- summary(coxph(x, data = data, subset = .(substitute(subset))))))
    hr <- format(cox$conf.int[1, c(1, 3, 4)], digits = 2)
    p <- format(cox$sctest[3], digits = 2)
    txt1 <- paste('HR = ', hr[1], ' (', hr[2], ' - ', hr[3], ')', sep = '')
    txt2 <- paste('logrank P =', p)
    legend(hr.pos, legend = c(txt1, txt2), bty = 'n')
  }
  if(show.nrisk) {
    addNrisk(s, labels = snames,
      col = if(color.nrisk) col else 1)
  }
  if(ns == 2) return(invisible(c(txt1, txt2)))
}



censor <- function(x, at) {
  stopifnot(class(x) == 'Surv')
  stopifnot(attr(x, "type") == "right")
  wh <- x[, 'time'] > at
  x[wh, 'time'] <- at 
  x[wh, 'status'] <- 0
  x
}


cutn <- function(x, n = 2, right = TRUE, ...) {
    stopifnot(n >= 1)
    xUnique <- sort(na.omit(unique(x)))
    nUnique <- length(xUnique)
    if(n > nUnique) n <- nUnique
    if(nUnique == 0) {
        return(factor(rep(NA, length(x))))
    } else {
        if (nUnique == 1) {
            breaks <- pretty(x)
        } else if (nUnique == n) {
            if(right) {
                breaks <- c(pretty(extendrange(xUnique[1:2]))[1], xUnique)
            } else {
                breaks <- c(xUnique, tail(pretty(extendrange(tail(xUnique, n = 2))), n = 1))
            }
        } else {
            breaks <- quantile(x, probs = seq(0, 1, length = n + 1), na.rm = TRUE)
            ## try to fix some relatively common problems
            if(breaks[1] == breaks[2] && n >= 2) { 
                breaks[2] <- mean(c(breaks[2], min(x[x > breaks[2]], na.rm = TRUE)))
            }
            if (breaks[n] == breaks[n + 1] && n >= 2) { 
                breaks[n] <- mean(c(breaks[n], max(x[x < breaks[n]], na.rm = TRUE)))
            }
        }  
        return(cut(x, breaks = unique(breaks), include.lowest = TRUE, right = right, ...))
    }
}

invert <- function(x) {
  stopifnot(class(x) == 'Surv')
  x[,2] <- 1 - x[,2]
  x
}




