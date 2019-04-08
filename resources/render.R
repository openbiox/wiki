# 设置下要操作的工作路径
setwd("~/Documents/GitHub/openbiox-wiki/resources")

library(rmarkdown)
library(logging)
library(sqldf)
library(openxlsx)
library(stringr)

wiki_sqldf <- function(logger, x, ..., log_file="wiki_operation.log") {
  # 参数x: 	SQL语句
  # Character string representing an SQL select statement or character vector whose 
  # components each represent a successive SQL statement to be executed. 
  # The select statement syntax must conform to the particular database being used. 
  # If x is missing then it establishes a connection which subsequent sqldf statements access. 
  # In that case the database is not destroyed until the next sqldf statement with no x.
  #
  # 其他不显示的参数会自动传入sqldf中
  # 见?sqldf::sqldf
  basicConfig(level='FINEST')
  message("Logging:")
  addHandler(writeToFile, file=log_file, level='DEBUG')
  loginfo(x, logger=logger)
  cat("\n")
  sqldf(x=x, ...)
}

wiki_render <- function(tb, title, output_file, template_rmd="template.Rmd", html_preview=FALSE) {
  tb <- tb
  title <- title
  rmarkdown::render('template.Rmd', output_file = output_file,
                    output_options = list(html_preview=html_preview))
}


# 经费
funds <- read.xlsx("20190404.xlsx", 1, colNames = F)
colnames(funds) <- funds[3,]
funds <- funds[c(-1,-2,-3),]
funds[,6] <- as.numeric(funds[,6])
funds[,1] <- as.numeric(funds[,1])
funds[,1] <- sapply(funds[,1], function(x) {
  date <- as.Date(x, origin = "1899-12-30")
  return(format(date, "%Y-%m-%d"))
})

# 项目团队
projects <- read.xlsx("20190404.xlsx", 2, colNames = F)
colnames(projects) <- projects[2,]
projects <- projects[c(-1,-2),]
projects[,3] <- as.numeric(projects[,3])
projects[,3] <- sapply(projects[,3], function(x) {
  date <- as.Date(x, origin = "1899-12-30")
  return(format(date, "%Y-%m-%d"))
})
projects[,9] <- sapply(projects[,9], function(x) {
  gsub('*', '\\*', x, fixed = TRUE)
})

# 设备
device <- read.xlsx("20190404.xlsx", 3, colNames = F)
colnames(device) <- device[2,]
device <- device[c(-1,-2),]
device[,1] <- as.numeric(device[,1])
device[,1] <- sapply(device[,1], function(x) {
  date <- as.Date(x, origin = "1899-12-30")
  return(format(date, "%Y-%m-%d"))
})

# 输出表格
TITLE <- "openbiox经费收支记录"
wiki_render(funds, TITLE, "funds.md", html_preview = TRUE) 
# 这里会生成markdown文件，然后也设置预览, 查看生成的html文件
# 然后将数据以RData格式保存
save(funds, file="funds.RData")

TITLE <- "openbiox项目团队"
wiki_render(projects, TITLE, "projects.md", html_preview = TRUE) 
save(projects, file="projects.RData")

TITLE <- "openbiox设备"
wiki_render(device, TITLE, "device.md", html_preview = TRUE) 
save(device, file="device.RData")


# 如果需要更改（即进行更新）
# 先使用wiki_sqldf函数
# 该函数执行操作并保存操作日志
load(file="tb.RData")
tb <- wiki_sqldf(logger="Shixiang Wang", x = "select * from tb limit 5")

# 现在只保留5行（即更新了）
# 然后再更新markdown文件
wiki_render(tb, TITLE, "test_file.md") 



