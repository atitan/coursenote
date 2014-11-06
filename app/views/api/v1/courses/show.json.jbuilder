json.course do
  json.id    @course.id
  json.name  @course.name
  json.code  @course.code
  json.credit  @course.credit
  json.teacher @course.teacher.name
  json.course_category @course.course_category.name
  json.department @course.department.name
end