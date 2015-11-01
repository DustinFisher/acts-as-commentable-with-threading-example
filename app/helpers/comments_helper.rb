module CommentsHelper
  def stack_helper(comments)
    i = 0
    level_end = false
    stack = comments.to_a

    while comment = stack.pop
      if comment == :end
        i-=1
        level_end = true
        next
      end

      yield comment, i, level_end
      i+=1
      level_end = false
      stack.push(:end)
      stack.concat(comment.children)
    end
  end
end
