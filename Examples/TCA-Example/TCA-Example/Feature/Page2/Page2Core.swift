import ComposableArchitecture

public struct Page2: Reducer {

  // MARK: Lifecycle

  public init() { }

  // MARK: Public

  public struct State: Equatable {
    var paths: [String] = []
  }

  public enum Action: Equatable {
    case getPaths
    case onTapNext
    case onTapRootPage3
    case onRemovePage1
    case onTapBack
  }

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .getPaths:
        state.paths = sideEffect.getPaths()
        return .none

      case .onTapNext:
        sideEffect.routeToPage3()
        return .none

      case .onTapRootPage3:
        sideEffect.routeToRootPage3()
        return .run { await $0(.getPaths) }

      case .onRemovePage1:
        sideEffect.removePage1()
        return .run { await $0(.getPaths) }

      case .onTapBack:
        sideEffect.routeToBack()
        return .none
      }
    }
  }

  // MARK: Internal

  @Dependency(\.sideEffect.page2) var sideEffect

}
