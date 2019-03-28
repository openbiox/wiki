# 设置下要操作的工作路径
setwd("~/Documents/GitHub/openbiox-wiki/template")

library(rmarkdown)
library(logging)
library(sqldf)

operate_wiki <- function(logger, x, ..., log_file="wiki_operation.log") {
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

render_wiki <- function(tb, title, output_file, template_rmd="template.Rmd", html_preview=FALSE) {
  tb <- tb
  title <- title
  rmarkdown::render('template.Rmd', output_file = output_file,
                    output_options = list(html_preview=html_preview))
}


# 假设你现在已经清理好了数据，把它变成了data.frame
# 这里随便创建一个数据
tb <- data.frame(a = c(1:10), b = c(1:10), c = c(1:10))

# 如果不需要进行修改，直接输出为表格形式 （第一次整理）
TITLE <- "测试日志"
render_wiki(tb, TITLE, "test_file.md", html_preview = TRUE) 
# 这里会生成markdown文件，然后也设置预览, 查看生成的html文件
# 然后将数据以RData格式保存
save(tb, file="tb.RData")

# 如果需要更改（即进行更新）
# 先使用operate_wiki函数
# 该函数执行操作并保存操作日志
load(file="tb.RData")
tb <- operate_wiki(logger="Shixiang Wang", x = "select * from tb limit 5")

# 现在只保留5行（即更新了）
# 然后再更新markdown文件
render_wiki(tb, TITLE, "test_file.md") 



