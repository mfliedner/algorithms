class BSTNode
  attr_accessor :left, :right
  attr_reader :value

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
end

class BinarySearchTree
  def initialize
    @root = nil
  end

  def insert(value)
    @root = BinarySearchTree.insert!(@root, value)
  end

  def find(value)
    BinarySearchTree.find!(@root, value)
  end

  def inorder
    BinarySearchTree.inorder!(@root)
  end

  def postorder
    BinarySearchTree.postorder!(@root)
  end

  def preorder
    BinarySearchTree.preorder!(@root)
  end

  def height
    BinarySearchTree.height!(@root)
  end

  def min
    BinarySearchTree.min(@root)
  end

  def max
    BinarySearchTree.max(@root)
  end

  def delete(value)
    BinarySearchTree.delete!(@root, value)
  end

  def self.insert!(node, value)
    return BSTNode.new(value) unless node

    if value > node.value
      node.right = insert!(node.right, value)
    else
      node.left = insert!(node.left, value)
    end

    node
  end

  def self.find!(node, value)
    return node if node.nil? || node.value == value

    value > node.value ? find!(node.right, value) : find!(node.left, value)
  end

  def self.preorder!(node)
    return [] unless node

    preorder = [node.value]
    preorder += preorder!(node.left) if node.left
    preorder += preorder!(node.right) if node.right

    preorder
  end

  def self.inorder!(node)
    return [] unless node

    inorder = []
    inorder += inorder!(node.left) if node.left
    inorder << node.value
    inorder += inorder!(node.right) if node.right

    inorder
  end

  def self.postorder!(node)
    return [] unless node

    postorder = []
    postorder += postorder!(node.left) if node.left
    postorder += postorder!(node.right) if node.right
    postorder << node.value

    postorder
  end

  def self.height!(node)
    return -1 unless node

    left = height!(node.left)
    right = height!(node.right)

    [left, right].max + 1
  end

  def self.max(node)
    return nil unless node

    max_node = node
    if max_node.right
      max_node = max(max_node.right)
    end

    return max_node
  end

  def self.min(node)
    return nil unless node

    min_node = node
    if min_node.left
      min_node = min(min_node.left)
    end

    return min_node
  end

  def self.delete_min!(node)
    return nil unless node
    return node.right unless node.left

    node.left = delete_min!(node.left)

    node
  end

  def self.delete!(node, value)
    return nil unless node

    if value < node.value && node.left
      node.left = delete!(node.left, value)
    elsif value > node.value && node.right
      node.right = delete!(node.right, value)
    else
      return node.right unless node.left
      return node.left unless node.right
      del_node = node
      node = del_node.right.min
      node.left = del_node.left
      node.right = delete_min!(del_node.right)
    end

    node
  end
end
