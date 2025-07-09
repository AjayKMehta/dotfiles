---
mode: 'agent'
description: 'Ensure .NET/C# code meets best practices for the solution/project.'
---
# .NET/C# Best Practices

Your task is to ensure .NET/C# code in ${selection} meets the best practices specific to this solution/project. This includes:

## Documentation & Structure

- Create comprehensive XML documentation comments for all public classes, interfaces, methods, and properties
- Include parameter descriptions and return value descriptions in XML comments
- Follow the established namespace structure: {Core|Console|App|Service}.{Feature}

## Design Patterns & Architecture

- Use nullable reference types (`<Nullable>Enable</Nullable>`)
- Do not use primary constructor syntax
- Implement the Command Handler pattern with generic base classes (e.g., `CommandHandler<TOptions>`)
- Use interface segregation with clear naming conventions (prefix interfaces with 'I')
- Follow the Factory pattern for complex object creation.

## Dependency Injection & Services

- Use constructor dependency injection
- Register services with appropriate lifetimes (Singleton, Scoped, Transient)
- Use `Microsoft.Extensions.DependencyInjection` patterns
- Implement service interfaces for testability

## Resource Management & Localization

- Use ResourceManager for localized messages and error strings
- Separate LogMessages and ErrorMessages resource files
- Access resources via `_resourceManager.GetString("MessageKey")`

## Async/Await Patterns

- Use async/await for all I/O operations and long-running tasks
- Return `Task` or `Task<T>` from async methods
- Use `ConfigureAwait(false)` where appropriate
- Handle async exceptions properly

## Testing Standards

- Follow AAA pattern (Arrange, Act, Assert)
- Test both success and failure scenarios

## Configuration & Settings

- Use strongly-typed configuration classes with data annotations
- Implement validation attributes (`Required`, `NotEmptyOrWhitespace`)
- Use `IConfiguration` binding for settings
- Support appsettings.json configuration files

## Semantic Kernel & AI Integration

- Use `Microsoft.SemanticKernel` for AI operations
- Implement proper kernel configuration and service registration
- Handle AI model settings (`ChatCompletion`, `Embedding`, etc.)
- Use structured output patterns for reliable AI responses

## Error Handling & Logging

- Use structured logging with `Microsoft.Extensions.Logging`
- Include scoped logging with meaningful context
- Throw specific exceptions with descriptive messages
- Use try-catch blocks for expected failure scenarios

## Performance & Security

- Use C# 12+ features and .NET 9 optimizations where applicable
- Implement proper input validation and sanitization
- Use parameterized queries for database operations
- Follow secure coding practices for AI/ML operations

## Code Quality

- Ensure SOLID principles compliance
- Avoid code duplication through base classes and utilities
- Use meaningful names that reflect domain concepts
- Keep methods focused and cohesive
- Implement proper disposal patterns for resources
