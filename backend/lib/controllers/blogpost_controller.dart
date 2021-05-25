import '../backend.dart';

class BlogPostController extends ResourceController {
  BlogPostController(this.context);

  final ManagedContext context;

  @Operation.get()
  Future<Response> getBlogPost() async {
    final query = Query<ManagedBlogPost>(context);
    return Response.ok(await query.fetch());
  }

  @Operation.get('id')
  Future<Response> getBlogPostByID(@Bind.path('id') int id) async {
    final query = Query<ManagedBlogPost>(context)
      ..where((blogPost) => blogPost.id).equalTo(id);

    final blogPost = await query.fetchOne();

    if (blogPost == null) {
      return Response.notFound();
    }
    return Response.ok(blogPost);
  }

  @Operation.post()
  Future<Response> addBlogPost(
      @Bind.body(ignore: ["id"]) ManagedBlogPost blogPost) async {
    final query = Query<ManagedBlogPost>(context)..values = blogPost;
    return Response.ok(await query.insert());
  }


@Operation.put('id')
  Future<Response> updateBlogPost(@Bind.path('id') int id,
      @Bind.body(ignore: ["id"]) ManagedBlogPost blogPost) async {
    final query = Query<ManagedBlogPost>(context)
      ..where((blogPost) => blogPost.id).equalTo(id)
      ..values = blogPost;
    return Response.ok(await query.updateOne());
  }



@Operation.delete('id')
  Future<Response> deleteBlogPostByID(@Bind.path('id') int id) async {
    final query = Query<ManagedBlogPost>(context)
      ..where((blogPost) => blogPost.id).equalTo(id);

    final blogPost = await query.fetchOne();

    if (blogPost == null) {
      return Response.notFound();
    }
    return Response.ok(await query.delete());
  }

}


